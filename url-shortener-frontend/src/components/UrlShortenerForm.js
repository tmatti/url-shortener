import React, { Component } from 'react';
import axios from 'axios';
import ShortenedUrl from './ShortenedUrl';
import ShortenedUrlEdit from './ShortenedUrlEdit';

class UrlShortenerForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      urls: [],
      value: '',
      error: '',
      editingUrlId: null,
    }
  }

  handleChange = (event) => {
    this.setState({value: event.target.value});
  }

  handleSubmit = (event) => {
    axios.post('http://localhost:3000/shortened_urls',
    {
      redirect_url: this.state.value
    }
    )
    .then(response => {
      this.setState({
        urls: this.state.urls.concat(response.data),
        error: '',
        value: '',
      })
    })
    .catch(error => {
      this.setState({error: error.message});
    });
    event.preventDefault();
  }

  enableEdit = (id) => {
    this.setState({editingUrlId: id})
  }

  afterEdit = (url) => {
    const urlIndex = this.state.urls.findIndex(x => x.id === url.id);
    const urls = this.state.urls.slice();
    urls[urlIndex] = url;
    this.setState({
      urls: urls,
      editingUrlId: null
    });
  }

  render() {
    const urls = this.state.urls.slice();
    const urlList = urls.map(url => {
      if(this.state.editingUrlId === url.id) {
        return (
          <li key={url.id}>
            <ShortenedUrlEdit url={url}
              afterEdit={this.afterEdit}
            />
          </li>
        );
      } else {
        return (
          <li key={url.id}>
            <ShortenedUrl url={url}
              onClick={this.enableEdit}
            />
          </li>
        );
      }
    });
    return (
      <form onSubmit={this.handleSubmit}>
        <span className="error-message">
          {this.state.error}
        </span>
        <fieldset>
          <input
            type="text"
            placeholder="Shorten your link"
            className="shorten-input"
            autoComplete="off"
            value={this.state.value}
            onChange={this.handleChange}
          />
          <input
            type="submit"
            value="Shorten"
            className="shorten-button"
          />
        </fieldset>
        <div className="url-list">
          {urlList}
        </div>
      </form>
    )
  }
}

export default UrlShortenerForm;

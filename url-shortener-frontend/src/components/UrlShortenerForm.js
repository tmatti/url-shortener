import React, { Component } from 'react';
import axios from 'axios';

class UrlShortenerForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      urls: [],
      value: '',
      error: '',
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
      })
    })
    .catch(error => {
      this.setState({error: error.message});
    });
    event.preventDefault();
  }

  render() {
    const urls = this.state.urls.slice();
    const urlList = urls.map(url => {
      const link = 'http://localhost:3000/' + url.slug;
      return (
        <li key={url.id}>
          <a
            target="_blank"
            href={link}>
            {link}
          </a>
        </li>
      );
    });
    return (
      <form onSubmit={this.handleSubmit}>
        {this.state.error}
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

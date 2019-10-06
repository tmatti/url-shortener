import React, { Component } from 'react';
import axios from 'axios';

class ShortenedUrlEdit extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      url: this.props.url,
      value: this.props.url.redirect_url,
      error: '',
    }
  }

  handleUpdate = (event) => {
    axios.put('http://localhost:3000/shortened_urls/' + this.state.url.slug,
    {
      redirect_url: this.state.value
    }
    )
    .then(response => {
      this.setState({
        url: response.data,
        error: '',
      });
      this.props.afterEdit(this.state.url);
    })
    .catch(error => {
      console.log(error)
      this.setState({error: error.message});
    });
    event.preventDefault();
  }

  handleChange = (event) => {
    this.setState({value: event.target.value});
  }

  render() {
    const redirect_url = this.state.url.redirect_url;
    const shortened_url = 'http://localhost:3000/' + this.state.url.slug;
    return (
      <fieldset>
        <input
          type="text"
          className="edit-input"
          autoComplete="off"
          value={this.state.value}
          onChange={this.handleChange}
        />
        <a className="shortened-url"
          target="_blank"
          href={shortened_url}>
          {shortened_url}
        </a>
        <input className="confirm-button"
          type="button"
          value="confirm"
          onClick={this.handleUpdate}
        />
      </fieldset>
    )
  }
}

export default ShortenedUrlEdit;

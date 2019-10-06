import React, { Component } from 'react';

class ShortenedUrl extends React.Component {
  render() {
    const redirect_url = this.props.url.redirect_url;
    const shortened_url = 'http://localhost:3000/' + this.props.url.slug;
    return (
      <fieldset>
        <span className="redirect-url">
          {redirect_url}
        </span>
        <a className="shortened-url"
          target="_blank"
          href={shortened_url}>
          {shortened_url}
        </a>
        <input className="edit-button"
          type="button"
          value="edit"
          onClick={() => this.props.onClick(this.props.url.id)}
        />
      </fieldset>
    )
  }
}

export default ShortenedUrl;

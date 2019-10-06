import React, { Component } from 'react';


class UrlShortenerForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      urls: []
    }
  }
  render() {
    return (
      <form>
        <fieldset>
          <input
            type="text"
            placeholder="Shorten your link"
            className="shorten-input"
            autoComplete="off"
          />
          <input
            type="button"
            value="Shorten"
            className="shorten-button"
          />
        </fieldset>
      </form>
    )
  }
}

export default UrlShortenerForm;

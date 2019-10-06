import React from 'react';
import logo from './logo.svg';
import './App.css';
import UrlShortenerForm from './components/UrlShortenerForm';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>
          Create a clickable link
        </h1>
      </header>
      <div className="url-form-container">
        <UrlShortenerForm />
      </div>
    </div>
  );
}

export default App;

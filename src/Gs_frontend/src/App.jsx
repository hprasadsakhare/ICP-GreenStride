// App.js

import React, { useState } from 'react';
import { Gs_backend } from 'declarations/Gs_backend';
import './App.css';

function App() {
  const [formData, setFormData] = useState({
    source: '',
    destination: '',
    ticket_id: '',
    distance: ''
  });
  const [response, setResponse] = useState('');

  function handleInputChange(event) {
    const { name, value } = event.target;
    setFormData(prevData => ({
      ...prevData,
      [name]: value
    }));
  }

  async function handleSubmit(event) {
    event.preventDefault();
    try {
      const result = await Gs_backend.storeTravelInfo(formData);
      setResponse(JSON.stringify(result.ok));
    } catch (error) {
      setResponse(`Error: ${error.message}`);
    }
  }

  async function handleShowJourney() {
    try {
      const journey = await Gs_backend.getTravelInfo();
      setResponse(JSON.stringify(journey.ok));
    } catch (error) {
      setResponse(`Error: ${error.message}`);
    }
  }

  async function handleClaimReward() {
    try {
      const reward = await Gs_backend.claimReward();
      setResponse(JSON.stringify(reward));
    } catch (error) {
      setResponse(`Error: ${error.message}`);
    }
  }

  return (
    <>
    <div className="background-image" style={{backgroundImage: "url('./metro.jpg')"}}></div>
    <div className="app-container">




    <div className="app-container">
      <h1 className="app-title">GreenStride</h1>
      <img src="/logo2.svg" alt="DFINITY logo" style={{ display: 'block', margin: '0 auto', width: '100px' }} />
      
      <form className="input-form" onSubmit={handleSubmit}>
        {['destination', 'source', 'ticket_Id', 'distance'].map((item) => (
          <div key={item}>
            <label className="input-label" htmlFor={item}>
              Enter your {item.charAt(0).toUpperCase() + item.slice(1)}:
            </label>
            <input
              className="input-field"
              id={item}
              name={item}
              type="text"
              value={formData[item]}
              onChange={handleInputChange}
            />
          </div>
        ))}
        <button className="button" type="submit">Submit Your Journey</button>
      </form>

      <button className="button" onClick={handleShowJourney}>Show Your Journey</button>
      <button className="button" onClick={handleClaimReward}>Claim Reward</button>

      <section className="response-section">
        <h2>Response:</h2>
        <p>{response}</p>
      </section>
    </div>


    </div>
    </>
  );
}

export default App;
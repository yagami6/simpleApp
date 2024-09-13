import React, { useEffect, useState } from 'react';

const App = () => {
  const [message, setMessage] = useState('');

  useEffect(() => {
    fetch(`${process.env.REACT_APP_API_URL}`)
      .then(response => response.json())
      .then(data => setMessage(data.Hello));
  }, []);

  return (
    <div>
      <header>
        <h1>Hello World from React!</h1>
        <h2>Message from API: {message}</h2>
      </header>
    </div>
  );
};

export default App;

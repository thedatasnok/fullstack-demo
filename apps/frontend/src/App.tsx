import { useState } from 'react';
import './App.css';

const App = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [response, setResponse] = useState<string>();

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    fetch('/api/v1/auth/sign-in', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        username,
        password,
      }),
    })
      .then((res) => res.json())
      .then((json) => setResponse(JSON.stringify(json, null, 2)));
  };

  return (
    <div className='wrapper'>
      <h1>fullstack-demo-frontend</h1>

      <form onSubmit={handleSubmit} className='form'>
        <input
          name='username'
          placeholder='Username'
          type='text'
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />

        <input
          name='password'
          placeholder='Password'
          type='password'
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        <button type='submit'>Sign in</button>
      </form>

      <pre>{response ?? 'no response'}</pre>
    </div>
  );
};

export default App;

import { useState } from 'react';
import './App.css';

const App = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [response, setResponse] = useState<Response>();

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
    }).then((res) => setResponse(res));
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

      <pre>
        {response ? JSON.stringify(response.body, null, 2) : 'no response'}
      </pre>
    </div>
  );
};

export default App;

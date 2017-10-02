import React from 'react';
import ReactDOM from 'react-dom';
import { Link } from 'react-router-dom';

const greetUser = (user, logout) => {
  console.log("This is a test!");
  return(<div>
    <h2>Welcome! {user.username}</h2>
    <button onClick={logout}>Log Out</button>
  </div>
);};

const authLink = () => (
  <div>
    <Link to ="/signup">Sign Up</Link>
    <Link to ="/login">Login</Link>
  </div>
);

const greeting = ({currentUser, logout}) => (
  currentUser ? greetUser(currentUser, logout) : authLink()
);




export default greeting;

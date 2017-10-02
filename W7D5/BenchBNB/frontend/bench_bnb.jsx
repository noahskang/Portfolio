import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';
import { login, signup } from './actions/session_actions';

document.addEventListener('DOMContentLoaded', () => {
    let store = configureStore();
    window.store = store;
    // window.getState = store.getState;
    // window.dispatch = store.dispatch;
    window.login = login;
    // window.store = store;
    // window.signup = signup;
    const root = document.getElementById('root');
    ReactDOM.render(<Root store={ store }/>, root);
});


// window.logout = logout;
// window.receiveCurrentUser = receiveCurrentUser;

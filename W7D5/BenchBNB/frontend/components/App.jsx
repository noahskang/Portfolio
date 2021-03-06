import React from 'react';
import GreetingContainer from './greeting/greeting_container';
import SessionFormContainer from './session/session_form_container';

const App = () => (
  <div>
    <header>
      <h1>Bench Bnb</h1>
      <GreetingContainer />
    </header>

    <Route path = "/login" component = {SessionFormContainer} />
    <Route path = "/signup" component = {SessionFormContainer} />
  </div>
);

export default App;

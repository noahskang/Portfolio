import React from 'react';
import { Provider } from 'react-redux';
import TodoListContainer from "./todo_list/todo_list_container";

class App extends React.Component {

  render() {
    return (
      <div>
        <h1> Todo List!: </h1>
        <TodoListContainer/>
      </div>
    );
  }

}

export default App;

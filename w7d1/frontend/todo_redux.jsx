import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import {getAllTodos} from './reducers/selectors';
import {addTodo, addTodos, removeTodo} from "./actions/actions";
import Root from './components/root';
import TodoListContainer from "./components/todo_list/todo_list_container";

document.addEventListener('DOMContentLoaded', ()=> {
  const rootEl = document.getElementById('root');
  const store = configureStore();
  ReactDOM.render(<Root store={store}/>, rootEl);
  window.store = store;
  window.addTodo = addTodo;
  window.addTodos = addTodos;
  window.removeTodo = removeTodo;
});

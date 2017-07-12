import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';

import { fetchTodos } from './util/todo_api_util';
import {getAllTodos} from './reducers/selectors';
import {addTodo, addTodos, removeTodo} from "./actions/actions";
import getTodos from "./actions/todo_actions";
import TodoListContainer from "./components/todo_list/todo_list_container";

document.addEventListener('DOMContentLoaded', ()=> {
  const store = configureStore();
  const rootEl = document.getElementById('content');
  ReactDOM.render(<Root store={store}/>, rootEl);
  window.store = store;
});

// window.fetchTodos = fetchTodos;
// window.getTodos = getTodos;
// window.addTodo = addTodo;
// window.addTodos = addTodos;
// window.removeTodo = removeTodo;

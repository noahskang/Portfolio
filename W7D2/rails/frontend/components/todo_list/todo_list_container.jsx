import TodoList from "./todo_list";
import { connect } from 'react-redux';
import React from 'react';
import { getAllTodos } from "../../reducers/selectors";
import { addTodo, removeTodo } from "../../actions/actions";
import { getTodos, createTodo } from "../../actions/todo_actions";
import { fetchTodos } from '../../util/todo_api_util';

const mapStateToProps = state => ({
  todos: getAllTodos(state)
});

const mapDispatchToProps = dispatch => ({
  addTodo: todo => dispatch(addTodo(todo)),
  removeTodo: todo => dispatch(removeTodo(todo)),
  requestTodos: () => dispatch(getTodos()),
  makeTodo: todo => dispatch(createTodo(todo))
});

const TodoListContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);

export default TodoListContainer;

// When I invoke connect, it will use a currying pattern to return function 2. When I invoke function 2, I pass it a component. function 2 will then return a new component with state updated according to the props.

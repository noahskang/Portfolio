import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

const TodoList = ({todos, addTodo, removeTodo}) => {
  return (
    <div>
      <ul>
        {todos.map((todo) => (
          <TodoListItem
            key = {`todo-list-item${todo.id}`}
            removeTodo = {removeTodo}
            addTodo = {addTodo}
            todo = {todo}/>
        ))}
      </ul>
      <TodoForm addTodo={addTodo}/>
    </div>
  );
};

export default TodoList;

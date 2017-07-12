import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component {

  componentDidMount() {
    return this.props.requestTodos();
  }

 render () {
  const {todos, makeTodo, addTodo, removeTodo} = this.props;
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
      <TodoForm makeTodo={makeTodo}/>
    </div>
  );}
}

export default TodoList;

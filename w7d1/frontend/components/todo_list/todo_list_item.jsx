import React from 'react';

class TodoListItem extends React.Component {
  constructor(props){
    super(props);
    this.state = {
    };
    this.handleDelete = this.handleDelete.bind(this);
    this.toggle = this.toggle.bind(this);
  }

  handleDelete(){
    return this.props.removeTodo(this.props.todo);
  }

  toggle(){
    let newtodo = this.props.todo;
    newtodo.done = !newtodo.done;
    return this.props.addTodo(newtodo);
  }

  render(){
    return (
      <li>
        {this.props.todo.title}
        <br></br>
        <button onClick={this.handleDelete}>delete todo</button>
        <button onClick={this.toggle}>{this.props.todo.done ? "DONE" : "UNDO"}</button>
      </li>
    );
  }
}

export default TodoListItem;

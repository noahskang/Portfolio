import React from 'react';
import {uniqueId} from "../../util/util";

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      title : "",
      body: "",
      id: ""
    };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.updateTitle = this.updateTitle.bind(this);
    this.updateBody = this.updateBody.bind(this);
  }

  updateTitle(e){
    this.setState({title: e.target.value});
  }

  updateBody(e){
    this.setState({body: e.target.value});
  }

  handleSubmit(e){
    e.preventDefault();
    this.setState({id: uniqueId()});
    this.props.addTodo(this.state);
    this.setState({title : "",
    body: ""});
  }

  render () {
    return (
    <div>
      <h2>Title</h2>
      <form onSubmit = {this.handleSubmit}>
        <input
          type = "text"
          className = "Title"
          onChange = {this.updateTitle}
          value = {this.state.title}
        />
      <h2>Body</h2>
        <input
          type = "text"
          className = "Body"
          onChange = {this.updateBody}
          value = {this.state.body}
        />
      <br></br>
      <button>Create Todo!</button>
    </form>
    </div>
    );
  }
}

export default TodoForm;

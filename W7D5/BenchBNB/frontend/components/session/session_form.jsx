import React from 'react';
import {Link, withRouter} from 'react-router-dom';
import { Route } from 'react-router-dom';

// we use withrouter when we have a component that isn't rendered by a route component.
// Right now, sessionform isn't accessed by any route component. So we use withrouter.
// withrouter is a higher order component. it wraps a react component (such as session form).
// withrouter passes it the router props LOCATION, MATCH, and HISTORY.

class SessionForm extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			username: "",
			password: ""
		};
  }

  handleSubmit(e) {
    e.preventDefault();
    const user = Object.assign({}, this.state);
    this.props.processForm(user);
  }

  navLink(){
    if(this.props.formType === "login"){
      return <Link to="/signup">Sign up instead</Link>;
    } else {
      return <Link to= "/login">log in instead</Link>;
    }
  }

	renderErrors(){
		return(
			<ul>
				{this.props.erros.map((error, i) => (
					<li key = {`error-${i}`}>
						{error}
					</li>
				))}
			</ul>
		);
	}

  render(){
    return(
      <div>
        <form onSubmit = {this.handleSubmit}>
          Welcome to BenchBNB!
          <br/>
          Please {this.props.formType} or {this.navLink()}
          {this.renderErrors()}
					<Route path = "/" render={()=>(
							this.props.loggedIn ? ( <Redirect to = "/"/> ) : ( <Redirect to = "/login" /> )
						)} />
        </form>
      </div>
    );
  }

}

export default withRouter(SessionForm);

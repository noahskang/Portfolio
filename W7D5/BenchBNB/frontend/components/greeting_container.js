import { connect } from 'react-redux';
import { logout } from '../actions/session_actions'
import Greeting from './greeting';

const mapStateToProps = (state) => (
  currentUser: state.currentUser;
);

const mapDispatchToProps = (state) => (
  logout: () => dispatch(logout());
);

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Greeting);

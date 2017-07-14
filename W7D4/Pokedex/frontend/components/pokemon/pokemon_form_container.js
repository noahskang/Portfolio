import {makeNewPokemon} from '../../actions/pokemon_actions';
import {connect} from 'react-redux';
import ControlledComponent from './pokemon_form';

const mapDispatchToProps = (dispatch) => ({
  createPokemon: params => dispatch(makeNewPokemon(params))
});

const PokemonFormContainer = connect(
  mapDispatchToProps
)(ControlledComponent);

export default PokemonFormContainer;

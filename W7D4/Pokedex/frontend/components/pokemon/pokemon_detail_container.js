import {selectOnePokemon} from '../../reducers/selectors';
import {requestSinglePokemon} from '../../actions/pokemon_actions';
import PokemonDetail from './pokemon_detail';
import {connect} from 'react-redux';

export const mapStateToProps = ({pokemon, items}) =>({
  pokemon: pokemon.entities[pokemon.currentPoke],
  items
});

export const mapDispatchToProps = (dispatch) => ({
  requestSinglePokemon: id => dispatch(requestSinglePokemon(id))
});

const PokemonDetailContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(PokemonDetail);

export default PokemonDetailContainer;

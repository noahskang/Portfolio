import {RECEIVE_ALL_POKEMON, RECEIVE_ONE_POKEMON, RECEIVE_NEW_POKEMON} from '../actions/pokemon_actions';
import merge from 'lodash/merge';

const defaultState = () => ({
  entities: {},
  currentPoke: null,
});

const pokemonReducer = (state = defaultState(), action) => {
  Object.freeze(state);
  switch(action.type){
    case RECEIVE_ALL_POKEMON:
      return merge({}, state, {entities:action.pokemon});
    case RECEIVE_ONE_POKEMON:
      const poke = action.payload.poke;
      return merge({}, state, {
        entites: {[poke.id]:poke},
        currentPoke: poke.id
      });
    case RECEIVE_NEW_POKEMON:
      const payload = action.payload;
      return merge({}, state, {
        entites: {[payload.id]:payload},
        currentPoke: payload.id
      });
    default:
      return state;
  }
};

export default pokemonReducer;

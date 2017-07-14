import {merge} from 'lodash/merge';
import {RECEIVE_ALL_POKEMON, RECEIVE_ONE_POKEMON} from '../actions/pokemon_actions';


const defaultState = () => ({
});

const ItemsReducer = (state = {}, action) => {
  Object.freeze(state);
  switch(action.type){
    case RECEIVE_ONE_POKEMON:
      return action.payload.items;
    default:
      return state;
  }
};

export default ItemsReducer; 

import {combineReducers } from 'redux';
import pokemonReducer from './pokemon_reducer';
import ItemsReducer from './items_reducer';

const rootReducer = combineReducers({
  pokemon: pokemonReducer,
  items: ItemsReducer
});

export default rootReducer;

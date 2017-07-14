export const RECEIVE_ALL_POKEMON = 'RECEIVE_ALL_POKEMON';
export const RECEIVE_ONE_POKEMON = 'RECEIVE_ONE_POKEMON';
export const RECEIVE_NEW_POKEMON = 'RECEIVE_NEW_POKEMON';
import * as APIUtil from '../util/api_util';

export const receiveAllPokemon = (pokemon) => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
});

export const receiveNewPokemon = (payload) => ({
  type: RECEIVE_NEW_POKEMON,
  payload
});

export const receiveOnePokemon = (payload) => ({
  type: RECEIVE_ONE_POKEMON,
  payload
});

export const requestAllPokemon = () => (dispatch) => {
  return APIUtil.fetchAllPokemon()
    .then(pokemon => dispatch(receiveAllPokemon(pokemon)));
};

export const requestSinglePokemon = (id) => (dispatch) => {
  return APIUtil.fetchOnePokemon(id)
    .then(pokemon => dispatch(receiveOnePokemon(pokemon)));
};

export const makeNewPokemon = (params) => (dispatch) => {
  return APIUtil.createNewPokemon(params)
    .then(pokemon => dispatch(receiveNewPokemon(pokemon)));
};

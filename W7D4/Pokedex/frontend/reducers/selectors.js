import values from 'lodash/values';

export const selectAllPokemon = ({pokemon}) => (
  values(pokemon.entities)
);

export const selectOnePokemon = ({pokemon, items}) => ({
  poke: pokemon.entities[pokemon.currentPoke],
  items
});

export const selectPokemonItem = ({items}, id) => (
  items.find((item) => (item.id === id))
);

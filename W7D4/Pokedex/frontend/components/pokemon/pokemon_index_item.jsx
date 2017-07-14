import React from 'react';
import { Link } from 'react-router-dom';

const PokemonIndexItem = ({pokemon}) => (
    <li>
      <Link to={`/pokemon/${pokemon.id}`}>
        <img height='100px' width= '100px' src={pokemon.image_url} alt={pokemon.name}></img>
      </Link>
    </li>
);

export default PokemonIndexItem;

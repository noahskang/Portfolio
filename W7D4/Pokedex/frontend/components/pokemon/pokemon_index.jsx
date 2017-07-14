import React from 'react';
import PokemonIndexItem from './pokemon_index_item';
import PokemonDetailContainer from './pokemon_detail_container';
import PokemonFormContainer from './pokemon_form_container';
import { Route, HashRouter } from 'react-router-dom';

class PokemonIndex extends React.Component {

    constructor(props) {
        super(props);
    }

    render() {
      const pokemonItems = this.props.pokemon.map(poke =>
        <PokemonIndexItem key={poke.id} pokemon={poke} />);
      return (
        <div>

          <section className="pokedex">
            <Route path="/" exact component={PokemonFormContainer}/ >
            <ul>
              {pokemonItems}
            </ul>
          </section>
          <Route path="/pokemon/:pokemonId" component={PokemonDetailContainer}/ >
        </div>
      );
    }
    componentWillReceiveProps(){

    }

    componentDidMount() {
      this.props.requestAllPokemon();
    }
}

export default PokemonIndex;

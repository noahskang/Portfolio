import React from 'react';
import ItemDetailContainer from '../item/item_detail_container';
import {Link} from 'react-router-dom';
import { Route } from 'react-router-dom';

class PokemonDetail extends React.Component {
  constructor(props){
    super(props);
  }

  componentDidMount(){
    this.props.requestSinglePokemon(this.props.match.params.pokemonId);
  }

  componentWillReceiveProps(newProps){
    if(newProps.match.params.pokemonId != this.props.match.params.pokemonId){
      this.props.requestSinglePokemon(newProps.match.params.pokemonId);
    }
  }

  render(){
    const { pokemon, items } = this.props;
    if (!pokemon){
      return (<div></div>);
    }
    else {
        return(
          <div>
            <img height='100px' width= '100px' src={pokemon.image_url} alt={pokemon.name}/>
            <ul>{items.map((item)=> (<li key = {item.id}>
                <Link to={`/pokemon/${pokemon.id}/item/${item.id}`}>
                  <img height='100px' width= '100px' src={item.image_url} alt={item.name}/>
                </Link>
              </li>))}
            </ul>
            <Route path="/pokemon/:pokemonId/item/:itemId" component={ItemDetailContainer}/>
          </div>
        );
    }
  }
}

export default PokemonDetail;

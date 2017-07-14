import React from 'react';

class ControlledComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
       name: '',
       image_url: '',
       poke_type: 'bug',
       attack: '',
       defense: '',
       moves: {}
     };
    this.POKEMON_TYPES = ["fire", "water", "wind"];
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  update(property){
    return e=> this.setState({[property]: e.target.value});
  }

  handleSubmit(e) {
   e.preventDefault();
   this.props.makeNewPokemon(this.state)
     .then(data => this.props.history.push(`/pokemon/${data.id}`));
 }
 
  render () {
    return (
      <div>
        <form className="pokemon-form" onSubmit = {this.handleSubmit}>
          <input onChange={this.update('name')} type="text" placeholder="Name" value={this.state.name}/>
          <input onChange={this.update('image_url')} type="text" placeholder="Image Url" value={this.state.image_url}/>
          <select
             value={this.state.type}
             onChange={this.update('poke_type')}
             defaultValue="Select Pokemon Type">
             {this.POKEMON_TYPES.map((type, i) => {
               return <option value={type} key={i}>{type}</option>;
             })}
           </select>
          <button>Create Pokemon</button>
        </form>
      </div>
    );
  }

}

export default ControlledComponent;

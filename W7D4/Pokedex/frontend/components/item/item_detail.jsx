import React from 'react';

class ItemDetail extends React.Component{
  constructor(props){
    super(props);
  }

  render(){
    let item = this.props.item;
    console.log(this.props);
    // console.log(item);
    return(
      <div>
        <ul>
          // <img src={this.props.image_url}/>
          <li>{item.name}</li>
          <li>{item.happiness}</li>
          <li>{item.price}</li>
        </ul>
      </div>
    );
  }
}

export default ItemDetail;

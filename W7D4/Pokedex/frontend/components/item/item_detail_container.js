import {connect} from 'react-redux';
import ItemDetail from './item_detail';
import { selectPokemonItem } from '../../reducers/selectors';

export const mapStateToProps = (state, ownProps) => ({
  item: selectPokemonItem(state, parseInt(ownProps.match.params.itemId))
});

const ItemDetailContainer = connect(
  mapStateToProps
)(ItemDetail);

export default ItemDetailContainer;

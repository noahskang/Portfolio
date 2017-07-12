import { fetchTodos, postTodo } from "../util/todo_api_util";
import { addTodos, addTodo} from "../actions/actions";

export const getTodos = () => dispatch => (
  fetchTodos().then(todos => dispatch(addTodos(todos)))
);

export const createTodo = (todo) => dispatch => (
  postTodo(todo).then(response => dispatch(addTodo(response)))
);

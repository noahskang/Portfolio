export const fetchTodos = () => {
  return $.ajax({method: 'GET', url: '/api/todos' });
};

export const postTodo = todo => {
  return $.ajax({method: 'POST', url: '/api/todos', data: {todo}});
};

// Write a function that takes no arguments, makes a request to api/todos with a method of GET, and returns a promise.

const HanoiGame = require("./game");
const HanoiView = require("./hanoi-view");

console.log("Hello!");

$( () => {
  const rootEl = $('.hanoi');
  const game = new HanoiGame();
  const hanoi = new HanoiView(game, rootEl);
});

const GameView = function (game, ctx) {
  this.ctx = ctx;
  this.game = game;
  this.ship = this.game.addShip();
};

GameView.MOVES = {
  "w": [ 0, -1],
  "a": [-1,  0],
  "s": [ 0,  1],
  "d": [ 1,  0],
};

GameView.MOVES2 = {
  "8": [ 0, -1],
  "4": [-1,  0],
  "5": [ 0,  1],
  "6": [ 1,  0],
};

GameView.prototype.bindKeyHandlers = function () {
  const ship = this.ship;
  const ship2 = this.ship2;

  Object.keys(GameView.MOVES).forEach((k) => {
    let move = GameView.MOVES[k];
    key(k, function () { ship.power(move); });
  });

  Object.keys(GameView.MOVES2).forEach((k) => {
    let move = GameView.MOVES2[k];
    key(k, function () { ship2.power(move); });
  });

  key("space", function () { ship.fireBullet() });
  key("0", function () { ship2.fireBullet() });
};

GameView.prototype.start = function () {
  this.bindKeyHandlers();
  this.lastTime = 0;
  //start the animation
  requestAnimationFrame(this.animate.bind(this));
};

GameView.prototype.animate = function(time){
  const timeDelta = time - this.lastTime;

  this.game.step(timeDelta);
  this.game.draw(this.ctx);
  this.lastTime = time;

  //every call to animate requests causes another call to animate
  requestAnimationFrame(this.animate.bind(this));
};

module.exports = GameView;

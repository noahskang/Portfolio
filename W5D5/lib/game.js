// Holds collections of the asteroids, bullets, and your ship.
// Game.prototype.step method calls Game.prototype.move on all
// the objects, and Game.prototype.checkCollisions checks for colliding objects.
// Game.prototype.draw(ctx) draws the game.
// Keeps track of dimensions of the space; wraps objects
 // around when they drift off the screens.
 const Asteroid = require("./asteroid");
 const Bullet = require("./bullet");
 const Ship = require("./ship");
 const Util = require("./util");

const DIM_X = 1000;
const DIM_Y = 600;
const NUM_ASTEROIDS = 10;

class Game{

  constructor(){
    this.asteroids = [];
    this.addAsteroids();
  }

  addAsteroids() {
    for (var i = 0; i < NUM_ASTEROIDS.length; i++) {
      this.asteroids.push(new Asteroid({pos: this.randomPosition(),
         vel: this.randomVelocity()}));

    }
  }

  randomPosition(){
    return [Game.DIM_X*Math.random(), Game.DIM_Y*Math.random()];
  }

  randomVelocity(){
    return [2*Math.random(), 2*Math.random()];
  }

  allObjects() {
    return [].concat(this.ships, this.asteroids, this.bullets);
  }

  draw(ctx) {
    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
    ctx.fillStyle = Game.BG_COLOR;
    ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);

    this.allObjects().forEach((object) => {
      object.draw(ctx);
    });
  }

  moveObjects(delta) {
     this.allObjects().forEach((object) => {
       object.move(delta);
     });
   }
}

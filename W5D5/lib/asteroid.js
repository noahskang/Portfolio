// Spacerock. It inherits from MovingObject.

const Util = require("./util");
const MovingObject = require("./moving_object");
const Ship = require("./ship");
const Bullet = require("./bullet");

const DEFAULTS = {
	COLOR: "#505050",
	RADIUS: 25,
	SPEED: 4
};

class Asteroid extends MovingObject{
  constructor(options = {}){
    options.color = DEFAULTS.COLOR;
    options.pos = options.pos || options.game.randomPosition();
    options.radius = DEFAULTS.RADIUS;
    options.vel = options.vel || Util.randomVec(DEFAULTS.SPEED);
    super(options);
  }


}

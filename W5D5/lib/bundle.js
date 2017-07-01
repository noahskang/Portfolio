/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 2);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

// This is you! Another MovingObject subclass.


/***/ }),
/* 1 */
/***/ (function(module, exports) {

// Kill spacerocks with this. Also a MovingObject subclass.


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {


const Game = __webpack_require__(3);
const GameView = __webpack_require__(6);

document.addEventListener("DOMContentLoaded", function(){
  const canvasEl = document.getElementsByTagName("canvas")[0];
  canvasEl.width = Game.DIM_X;
  canvasEl.height = Game.DIM_Y;

  const ctx = canvasEl.getContext("2d");
  const game = new Game();
  new GameView(game, ctx).start();
});


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

// Holds collections of the asteroids, bullets, and your ship.
// Game.prototype.step method calls Game.prototype.move on all
// the objects, and Game.prototype.checkCollisions checks for colliding objects.
// Game.prototype.draw(ctx) draws the game.
// Keeps track of dimensions of the space; wraps objects
 // around when they drift off the screens.
 const Asteroid = __webpack_require__(4);
 const Bullet = __webpack_require__(1);
 const Ship = __webpack_require__(0);
 const Util = __webpack_require__(7);

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


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

// Spacerock. It inherits from MovingObject.

const Util = __webpack_require__(7);
const MovingObject = __webpack_require__(5);
const Ship = __webpack_require__(0);
const Bullet = __webpack_require__(1);

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


/***/ }),
/* 5 */
/***/ (function(module, exports) {

// Base class for anything that moves.
// Most important methods are MovingObject.prototype.move,
// MovingObject.prototype.draw(ctx),
// MovingObject.prototype.isCollidedWith(otherMovingObject).

// function MovingObject (options) {
//   for (var key in options) {
//     this[key] = options[key];
//   }
// }

class MovingObject {
  constructor(options) {
    this.pos = options.pos;
    this.vel = options.vel;
    this.radius = options.radius;
    // this.color = options.color;
    // this.game = options.game;
    // this.isWrappable = true;
  }

  draw(ctx) {
    ctx.fillStyle = this.color;
    
    ctx.beginPath();
    ctx.arc( this.pos[0], this.pos[1], this.radius, 0, 2 * Math.PI, true);
    ctx.fill();
  }

  move(){
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
  }
}

module.exports = MovingObject;


/***/ }),
/* 6 */
/***/ (function(module, exports) {

// Stores a Game instance.
// Stores a canvas context to draw the game into.
// Installs key listeners to move the ship and fire bullets.
// Installs a timer to call Game.prototype.step.


/***/ }),
/* 7 */
/***/ (function(module, exports) {

// Utility code, especially vector math stuff.

const Util = {
  inherits(childClass, parentClass){

  },

  randomVec (length) {
    const deg = 2 * Math.PI * Math.random();
    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
  },
// Scale the length of a vector by the given amount.
  scale (vec, m) {
    return [vec[0] * m, vec[1] * m];
  }
};

module.exports = Util;


/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map
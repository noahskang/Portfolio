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

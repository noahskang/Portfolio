
// `Function.prototype.inherits` using surrogate trick

Function.prototype.inherits = function(superclass){
  function Surrogate () {}
    Surrogate.prototype = superclass.prototype;
    this.prototype = new Surrogate();
    this.prototype.constructor = this;
};

// `Function.prototype.inherits` using `Object.create`
Function.prototype.inherits2 = function (BaseClass) {
  this.prototype = Object.create(BaseClass.prototype);
  this.prototype.constructor = this;
};

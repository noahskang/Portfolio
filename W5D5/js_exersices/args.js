function sum(...args){
  let storage = 0;
  for (var i = 0; i < args.length; i++) {
    storage += args[i];
  }
  return storage;
}
//
// console.log(sum(1, 2, 3, 4));
// console.log(sum(1, 2, 3, 4, 5));

// Function.prototype.myBind = function(ctx, ...bindArgs){
//   return (...callArgs) => {
//     return this.apply(ctx, bindArgs.concat(callArgs));
//   };
// };

// solutions with arguments key word
Function.prototype.myBind = function(ctx) {
  let args = [];
  for (let i = 1; i < arguments.length; i++) {
    args.push(arguments[i]);
  }
  const that = this;
  // console.log(args);
  return function() {
    // console.log(args);
    // console.log(arguments);
    for (let i = 0; i < arguments.length; i++) {
      args.push(arguments[i]);
    }
    // console.log(that);
    that.apply(ctx, args);
  } ;
};


class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

// const markov = new Cat("Markov");
// const breakfast = new Cat("Breakfast");

// markov.says("meow", "Ned");
// markov.says.myBind(breakfast, "meow", "Kush")();
// markov.says.myBind(breakfast)("meow", "a tree");
// markov.says.myBind(breakfast, "meow")("Markov");
// //
// const notMarkovSays = markov.says.myBind(breakfast);
// notMarkovSays("meow", "me");

function curriedSum(numArgs) {
  let numbers = [];
  function _curriedSum(num){
    numbers.push(num);
    if (numbers.length===numArgs) {
      return numbers.reduce((a,b) => a + b, 0);
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum;
}

// const sum2 = curriedSum(4);
// console.log(sum2(5)(20)(30)(15));

// apply
Function.prototype.curry = function(numArgs1) {
  let fn = this; //this and fn is the worst
  const args = [];
  function _curried(num) {
    args.push(num);
    if (args.length === numArgs1) {
      return fn.apply(null, args);
    } else {
      return _curried;
    }
  }
  return _curried;
};


// with rest operator

Function.prototype.curry = function(numArgs1) {
  let fn = this; //this and fn is the worst
  const args = [];
  function _curried(num) {
    args.push(num);
    if (args.length >= numArgs1) {
      return fn(...args);
    } else {
      return _curried;
    }
  }
  return _curried;
};


function x (...args) { return Array.from(args).reduce((a,b) => a + b);}
// console.log(x([1,2,3]));
const gather = x.curry(4);
console.log(gather(5)(20)(5)(2));

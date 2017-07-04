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
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const HanoiGame = __webpack_require__(1);
const HanoiView = __webpack_require__(2);

console.log("Hello!");

$( () => {
  const rootEl = $('.hanoi');
  const game = new HanoiGame();
  const hanoi = new HanoiView(game, rootEl);
});


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class Game {
  constructor() {
    this.towers = [[3, 2, 1], [], []];
  }

  isValidMove(startTowerIdx, endTowerIdx) {
      const startTower = this.towers[startTowerIdx];
      const endTower = this.towers[endTowerIdx];

      if (startTower.length === 0) {
        return false;
      } else if (endTower.length == 0) {
        return true;
      } else {
        const topStartDisc = startTower[startTower.length - 1];
        const topEndDisc = endTower[endTower.length - 1];
        return topStartDisc < topEndDisc;
      }
  }

  isWon() {
      // move all the discs to the last or second tower
      return (this.towers[2].length == 3) || (this.towers[1].length == 3);
  }

  move(startTowerIdx, endTowerIdx) {
      if (this.isValidMove(startTowerIdx, endTowerIdx)) {
        this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());
        return true;
      } else {
        return false;
      }
  }

  print() {
      console.log(JSON.stringify(this.towers));
  }

  promptMove(reader, callback) {
      this.print();
      reader.question("Enter a starting tower: ", start => {
        const startTowerIdx = parseInt(start);
        reader.question("Enter an ending tower: ", end => {
          const endTowerIdx = parseInt(end);
          callback(startTowerIdx, endTowerIdx)
        });
      });
  }

  run(reader, gameCompletionCallback) {
      this.promptMove(reader, (startTowerIdx, endTowerIdx) => {
        if (!this.move(startTowerIdx, endTowerIdx)) {
          console.log("Invalid move!");
        }

        if (!this.isWon()) {
          // Continue to play!
          this.run(reader, gameCompletionCallback);
        } else {
          this.print();
          console.log("You win!");
          gameCompletionCallback();
        }
      });
  }
}

module.exports = Game;


/***/ }),
/* 2 */
/***/ (function(module, exports) {

class HanoiView {

  constructor(game, $el){
    this.game = game;
    this.start;
    this.$el = $el;
    $el.append(this.setupTowers());
    this.render();
  }

  clickTower(){

    $(".tower").on("click", (e)=>{
      console.log("clicked");
      if (!this.start){
        this.start = $(e.currentTarget).attr("towerNum");
      }
      else {
        let end = $(e.currentTarget).attr("towerNum");
        if (!this.game.isValidMove(this.start, end)){
          alert("invalid move!");
        }
        else {
          this.game.move(this.start, end);
          this.render();
          console.log(this.start);
          console.log(end);

          if(this.game.isWon()){
            alert("Congrats! You won!!");
          }

          this.start = undefined;
        }
      }
    });
  }

  setupTowers() {
    const $towers = $("<div>");
    for (let i = 0; i < 3; i++) {
      const tower = this.setupTower(i);
      $towers.append(tower);
      // this.el.append(tower);
    }
    return $towers;
  }

  setupTower(idx) {
    const tower = $("<ul>").addClass("tower").attr("towerNum", idx);
    for (let i = 0; i < 3; i++) {
      if (idx===0){
        const bullet = $("<li>").addClass("t"+(i+1));
        tower.append(bullet);
      } else {
        tower.append($("<li>"));
      }
    }
    return tower;
  }

  render(){
    const $towers = $("<div>");
    // $towers.removeClass();

    // this.game.towers.forEach( (disks, towerIdx) => {
    //   const $disks = $towers.eq(towerIdx).children();
    //   $disks.removeClass();
    // });

    for (var i = 0; i < this.game.towers.length; i++) {
      let tower = $("<ul>").addClass("tower").attr("towerNum", i);
      for (var j = 0; j < this.game.towers[i].length; j++) {
        let disc = $("<li>").addClass("t"+(this.game.towers[i][j]));
        tower.append(disc);
      }
      $towers.append(tower);
    }
    console.log($towers);
    this.$el.empty();
    this.$el.append($towers);
    this.clickTower();
  }



}

module.exports = HanoiView;


/***/ })
/******/ ]);
const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

class Game{
    constructor() {
      this.stacks = this.defaultarray();
    }

    defaultarray(){
      let ary = new Array(3);
      for (var i = 0; i < ary.length; i++) {
        ary[i]=[];
      }
      return ary;
    }

    play(){
      this.stacks[0] = [3,2,1];
      this.promptMove(this.move.bind(this));
    }

    isWon(){
      if (this.stacks[1].length === 3 || this.stacks[2].length === 3){
        return true;
      } else {
        return false;
      }

      // this.stacks.slice(1).forEach((el)=>{
      //   if(el.length>=3){
      //     return true;
      //   }
      // });
      // return false;
    }

    render(){
      for (let i = 3; i >=0; i--) {
        let row = [];
        for (let j = 0; j < this.stacks.length; j++) {
          if(this.stacks[j][i]===undefined){
            row.push(" ");
          } else {
            row.push("|"+this.stacks[j][i]+"|");
          }
        }
        console.log(row.join(" "));
      }
      console.log(" -   -   - ");
    }

    promptMove(callback){
      this.render();
      reader.question("From where? e.g. 0, 1, 2: ", (res)=>{
        reader.question("To where? ", (res2)=>{
          let startTowerIdx = res;
          let endTowerIdx = res2;
          callback(startTowerIdx, endTowerIdx);
        });
      });
    }

    move(start, end){
      if (this.isValidMove(start, end)){
        this.stacks[end].push(this.stacks[start].pop());
        console.log(this);
        if (this.isWon()){
          console.log("game over :)");
          reader.close();
        } else {
          this.promptMove(this.move.bind(this));

        }
      } else {
        console.log("Invalid move");
        this.promptMove(this.move.bind(this));
      }
    }

    isValidMove(start, end){
      let length = this.stacks.length;
      if(start >= length || end >= length || start < 0 || end <0){
        return false;
      }

      let startTower = this.stacks[start];
      let endTower = this.stacks[end];

      if (startTower.length === 0){
        return false;
      }
      if(endTower.length ===0){
        return true;
      }
      if (startTower[startTower.length-1] > endTower[endTower.length-1]){
        return false;
      }
      return true;
    }
}

let game = new Game();
game.play();

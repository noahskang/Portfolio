class Clock{

  constructor () {
    var d = new Date();
    this.hr = d.getHours();
    this.min = d.getMinutes();
    this.sec = d.getSeconds();
    setInterval(Clock.prototype._tick.bind(this), 1000);
  }

  modifier(num){
    if (num < 10){ return `0${num}`;}
    // console.log(num);
    return num.toString();
  }

  printTime(){
    // console.log(this.hr);
    let hr = this.modifier(this.hr);
    let min = Clock.prototype.modifier(this.min);
    let sec = this.modifier(this.sec);
    console.log(`${hr}:${min}:${sec}`);
  }

  _tick(){
    // console.log(this);
    this.sec++;
    if (this.sec===60){
      this.sec = 0;
      this.min++;
    }
    if (this.min===60){
      this.min = 0;
      this.hr++;
    }
    if (this.hr===24){
      this.hr = 0;
    }
    this.printTime();
  }

}

const clock = new Clock();

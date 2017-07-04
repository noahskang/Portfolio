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

class View {
  constructor(game, $el) {
    $el.append(this.setupBoard());
    this.game = game;
    this.bindEvents();
  }

  bindEvents() {

    $(".square").on("click", (e) => {
      const $square = $(e.currentTarget);
      const $pos = $square.attr("data-pos");

      const col = $pos % 3;
      const row = Math.floor($pos / 3);

      if($square.attr("clicked")) {
        alert("Invalid move!");
      }
      else {
        this.makeMove($square);
        this.game.playMove([row, col]);
        if(this.game.isOver()){
          setTimeout(function(){
            alert(`congratulations ${this.game.winner()}`);
          }.bind(this), 2000);
        }
      }
    });

  }

  makeMove($square) {
    $square.css("background-color", "white");
    $square.attr("clicked", true);
    $square.text(this.game.currentPlayer);
  }

  setupBoard() {
    const $grid = $("<ul>").addClass("grid").addClass("group");
    for(let Idx = 0; Idx < 9; Idx++) {
      const $square = $("<li>").addClass("square").attr("data-pos", [Idx]);
      $grid.append($square);
    }
  return $grid;
  }
}

module.exports = View;

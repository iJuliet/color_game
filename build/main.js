(function() {
  var Game;

  Game = require("./game.cjsx");

  $(function() {
    var game;
    game = Game();
    return game.start();
  });

}).call(this);

{ColorBox} = require "./colorBox.cjsx"
React = require "react"
Menu = require "./Menu.cjsx"

class Game

  start: ->
    menu = Menu()
    React.render menu, document.getElementById('content')


$ ->
  game = new Game()
  game.start()

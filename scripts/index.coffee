yelpAPI = require "./scripts/yelpAPI.coffee"
resultBox = require "./scripts/resultBox.coffee"

data = undefined


StartButton = React.createClass

  displayName: "Start"

  onClick: ->
    data = yelpAPI.startSearch("156 front street west, toronto", "food")
    console.log data

  render: ->
  	React.DOM.div {id:"result-box"}
      React.DOM.button {"btn", @onClick}, "start"




$ ->
  btn = StartButton()
  React.renderComponent btn, document.getElementById('content')
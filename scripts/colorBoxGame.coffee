

colors = ['red', 'yellow', 'blue', 'green']

colorBox = React.createClass
  
  constructor: ->
    randomNumber = Math.floor(Math.random() * 10000000000000000) % (colors.length)
    @color = colors[randomNumber]

  generateRandomNumber: ->
    Math.floor(Math.random() * 10000000000000000) % (colors.length)

  changeColor: ->
    randomNumber = generateRandomNumber()
    @color = colors[randomNumber]

  render: ->
    
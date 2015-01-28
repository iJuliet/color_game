
React = require "react"

COLORS = ['red', 'yellow', 'blue', 'green']
MAXINDEX = 7
TOTAL = (MAXINDEX + 1)*(MAXINDEX + 1)
colorsArray = []


ColorBox = React.createClass
  
  getInitialState: ->
    for row in [0..MAXINDEX]
      for col in [0..MAXINDEX]
        colorsArray[row*(MAXINDEX+1)+col] = new colorSquare()
    {
      coveredAmount: 0
      colors: colorsArray
      surroundingIndex: []
    }

  componentDidMount: ->
    console.log "did mount"
    # set the first color as covered
    colorsArray[0].hasBeenCovered = yes
    @setState
      coveredAmount: 0
      colors: colorsArray
      surroundingIndex: (@state.surroundingIndex.push 0)
    @updateColor(colorsArray[0].color)

    

  # this function updates the surroundings of the current
  # covered area
  updateSurroundings: (selectedColor, previousSurroundings, coveredAmount) ->
    surroundings = previousSurroundings
    covered = coveredAmount
    hasUpdated = no
    i = 0
    while(i < previousSurroundings.length)
      selectedIndex = previousSurroundings[i]
      i++
      console.log previousSurroundings, selectedIndex
      row = Math.floor (selectedIndex / (MAXINDEX+1))
      col = selectedIndex % (MAXINDEX+1)
      if colorsArray[selectedIndex].color is selectedColor
        # update the color
        colorsArray[selectedIndex].update(selectedColor)
        covered++
        #remove from surroundingIndex
        surroundings.splice(surroundings.indexOf(row*(MAXINDEX+1)+col), 1)
        # update surroundingIndex

        leftIndex = row * (MAXINDEX + 1) + col - 1
        rightIndex = row * (MAXINDEX + 1) + col + 1
        upIndex = (row - 1) * (MAXINDEX + 1) + col
        downIndex = (row + 1) * (MAXINDEX + 1) + col
        if (row - 1) >= 0 and 
            not colorsArray[upIndex].hasBeenCovered and 
            surroundings.indexOf(upIndex) is -1
          surroundings.push upIndex
          console.log upIndex
        if (row + 1) <= MAXINDEX and
            not colorsArray[downIndex].hasBeenCovered and 
            surroundings.indexOf(downIndex) is -1
          surroundings.push downIndex
          console.log downIndex
        if (col - 1) >= 0 and
            not colorsArray[leftIndex].hasBeenCovered and 
            surroundings.indexOf(leftIndex) is -1
          surroundings.push leftIndex
          console.log leftIndex
        if (col + 1) <= MAXINDEX and
            not colorsArray[rightIndex].hasBeenCovered and 
            surroundings.indexOf(rightIndex) is -1
          surroundings.push rightIndex
          console.log rightIndex

        hasUpdated = yes
    
    if hasUpdated
      # need to go for next round
      @updateSurroundings(selectedColor, surroundings, covered)
    else
      if covered is TOTAL
        # win!
        console.log "Game Ends"
      
      @setState
        coveredAmount: covered
        surroundingIndex: surroundings
        colors: colorsArray
      return
      

  updateColor: (selectedColor) ->
    #update covered
    i = 0
    while i < TOTAL
      if @state.colors[i].hasBeenCovered
        colorsArray[i].update(selectedColor)
      i++
      
    @updateSurroundings(selectedColor, @state.surroundingIndex, @state.coveredAmount)

    


      # ...
    
      # ...
    

        
  allSameColor: ->
    color = @state.colors[0].color
    for row in [0..MAXINDEX]
      for col in [0..MAXINDEX]
        colorSquare = @state.colors[row*(MAXINDEX + 1)+col]
        if colorSquare.color isnt color
          return false
    return true

  preupdateSurroundings: (row, col) ->
    selectedColor = @state.colors[row*(MAXINDEX + 1)+col].color
    ###
    upIndex = selectedIndex - (MAXINDEX + 1)
    downIndex = selectedIndex + (MAXINDEX + 1)
    leftIndex = selectedIndex - 1
    rightIndex = selectedIndex + 1
    
    if selectedIndex is 0
      # check right, down
      checkRight = yes
      checkDown = yes
    else if selectedIndex is 7
      # check left, down
      checkLeft = yes
      checkDown = yes
    else if selectedIndex is 56
      # check right, up
      checkRight = yes
      checkUp = yes
    else if selectedIndex is 63
      # check left, up
      checkLeft = yes
      checkUp = yes
    else if selectedIndex > 0 and selectedIndex < 7
      # check down, left, right
      checkDown = yes
      checkLeft = yes
      checkRight = yes
    else if (selectedIndex%(MAXINDEX + 1)) is 0
      # check up, down, right
      checkUp = yes
      checkDown = yes
      checkRight = yes
    else if (selectedIndex%(MAXINDEX + 1)) is 7
      # check up, down, left
      checkUp = yes
      checkDown = yes
      checkLeft = yes
    else if selectedIndex > 56 and selectedIndex < 63
      # check left, right, down
      checkLeft = yes
      checkRight = yes
      checkDown = yes
    else
      # the square is in the middle
      # check left, right, up, down
      checkLeft = yes
      checkRight = yes
      checkUp = yes
      checkDown yes
    

    

    if checkLeft and colorArray[leftIndex].color is selectedColor
      colorArray[leftIndex].preupdate()
    if checkRight and colorArray[rightIndex].color is selectedColor
      colorArray[rightIndex].preupdate()
    if checkUp and colorArray[upIndex].color is selectedColor
      colorArray[upIndex].preupdate()
    if checkDown and colorArray[downIndex].color is selectedColor
      colorArray[downIndex].preupdate()
    ###

    leftIndex = row * (MAXINDEX + 1) + col - 1
    rightIndex = row * (MAXINDEX + 1) + col + 1
    upIndex = (row - 1) * (MAXINDEX + 1) + col
    downIndex = (row + 1) * (MAXINDEX + 1) + col

    if (colorsArray[upIndex].hasBeenCovered or colorsArray[upIndex].shouldUpdate) and
        (colorsArray[downIndex].hasBeenCovered or colorsArray[downIndex].shouldUpdate) and
        (colorsArray[leftIndex].hasBeenCovered or colorsArray[leftIndex].shouldUpdate) and
        (colorsArray[rightIndex].hasBeenCovered or colorsArray[rightIndex].shouldUpdate)
      return 

    if (row - 1) >= 0 and colorsArray[upIndex].color is selectedColor
      colorsArray[upIndex].preupdate()
      @preupdateSurroundings(row-1, col)
    if (row + 1) <= 7 and colorsArray[downIndex].color is selectedColor
      colorsArray[downIndex].preupdate()
      @preupdateSurroundings(row+1, col)
    if (col - 1) >= 0 and colorsArray[leftIndex].color is selectedColor
      colorsArray[leftIndex].preupdate()
      @preupdateSurroundings()
    if (col + 1) <= 7 and colorsArray[rightIndex].color is selectedColor
      colorsArray[rightIndex].preupdate()

    return

  render: ->
    squares = []
    for row in [0..MAXINDEX]
      onerow = []
      for col in [0..MAXINDEX]
        index = row * (MAXINDEX + 1) + col
        color = @state?.colors[index].color
        onesquare = 
          <td>
            <button
              type="button"
              className="btn square-btn color-btn[#{index}] #{color}-btn"
            >
            </button>
          </td>
        onerow.push onesquare
      wrappedRow = 
        <tr>
          {onerow}
        </tr>
      squares.push wrappedRow
    colorButtons = []
    for color in COLORS
      btn = 
        <button
          type="button"
          className="btn #{color}-btn game-btn"
          onClick={@updateColor.bind this, color}
        >
        {color}
        </button>
      colorButtons.push btn

    <div>
      <h1>Color Game</h1>
      <div id="color-box">
        <span>
          <p>
            Click on one of the color buttons, it will cover
          </p>
          <table border="1">
            {squares}
          </table>
        </span>
        <p>Covered Amount: {@state?.coveredAmount}</p>
        <div class="color-buttons">{colorButtons}</div>
      </div>
     </div>

class colorSquare

  constructor: ->
    randomNumber = Math.floor(Math.random() * 10000000000000000) % (COLORS.length)
    @color = COLORS[randomNumber]
    @hasBeenCovered = no
    @shouldUpdate = no

  update: (color) ->
    @color = color
    @hasBeenCovered = yes
    @shouldUpdate = no

  preupdate: (color) ->
    @shouldUpdate = yes


module.exports = 
  ColorBox: ColorBox
  colorSquare: colorSquare



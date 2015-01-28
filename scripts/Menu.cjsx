{ColorBox} = require "./colorBox.cjsx"
React = require "react"


MenuBox = React.createClass
  
  getInitialState: ->
    {
      hasStarted: no
    }
  
  onClickStartButton: ->
    #init color box
    @setState
      hasStarted: yes


  render: ->
    if @state?.hasStarted
      content = <ColorBox />
    else
      content = 
        <button
          type="button"
          className="btn round start-button"
          onClick={@onClickStartButton}
        >
          Start
        </button>
    <div>
      <span>
        {content}
      </span>
    </div>

module.exports = MenuBox
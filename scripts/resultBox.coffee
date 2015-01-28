module.exports = 

  show : (data) ->
    
    generateNameLabel: ->
      name = data.name
      React.DOM.h2 name

    generateLocationLabel: ->
      address = data.location.address[0]
      React.DOM.h2 address

    generateRatingImg: ->
      imgSrc = data.rating_image_url
      React.DOM.img {src:imgSrc}

    generateImage: ->
      src = data.image_url
      React.DOM.img {src: src}

    Box = React.createClass
      onClick: ->
        console.log "clicked on go button"
        window.open data.url
      render: ->
        name = data.name
        detailAddress = data.location.address[0]
        ratingImgSrc = data.rating_img_url
        imgSrc = data.image_url
        React.DOM.div null,
          React.DOM.h2 null, name
          React.DOM.div null,
            React.DOM.img {src:imgSrc, width: "150px", height: "150px", @onClick}
          React.DOM.div null,
            React.DOM.img {src:ratingImgSrc}
          React.DOM.h4 null, detailAddress
          React.DOM.button {className:"belize-hole-flat-button", @onClick}, "I want more details"

    console.log data
    box = Box()
    React.renderComponent box, document.getElementById('result-box')

  
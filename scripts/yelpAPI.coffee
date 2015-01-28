URI = require 'URIjs'
OAuth = require 'oauth-1.0a'

ResultBox = require "./resultBox.coffee"


module.exports = new class yelpAPI
  oauth_consumer_key = "WOk3A1nLkPV4Wua4GILhqg"
  oauth_consumer_secret = "7xltEeFoa7JEduL_xpcxjFkzzQU"
  oauth_token = "bDcv4M91vumpDMxv37-skUKK1xhsBqle"
  oauth_signature = "uaBGwcandamx_kGYem-HojRZIH8"

  search_path = "/v2/search"
  default_location = "toronto"

  api_host = "http://api.yelp.com/v2/search"
  response = undefined

  startSearch: (location, term) ->
    consumer = 
      public : oauth_consumer_key
      secret : oauth_consumer_secret
    token = 
      public : oauth_token
      secret : oauth_signature
    signature_method = "HMAC-SHA1"
    oauth = OAuth {consumer, signature_method}
    requestData = 
      url  : api_host
      method : 'GET'
      data :
        term : term
        location : location
        sort : 1
    $.ajax
      url : requestData.url
      data: oauth.authorize(requestData, token)
      success: (data, textStatus, jqXHR) ->
        console.log data
        response = data
        randomNumber = Math.floor(Math.random() * 10000000000000000) %20
        console.log randomNumber
        ResultBox.show data.businesses[randomNumber]
      error: (jqXHR, textStatus, errorThrown) ->
        console.log errorThrown

    if response
      return response
    else
      return "no data"
    

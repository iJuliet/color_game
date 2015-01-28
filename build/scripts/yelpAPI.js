(function() {
  var OAuth, ResultBox, URI, yelpAPI;

  URI = require('URIjs');

  OAuth = require('oauth-1.0a');

  ResultBox = require("./resultBox.coffee");

  module.exports = new (yelpAPI = (function() {
    var api_host, default_location, oauth_consumer_key, oauth_consumer_secret, oauth_signature, oauth_token, response, search_path;

    function yelpAPI() {}

    oauth_consumer_key = "WOk3A1nLkPV4Wua4GILhqg";

    oauth_consumer_secret = "7xltEeFoa7JEduL_xpcxjFkzzQU";

    oauth_token = "bDcv4M91vumpDMxv37-skUKK1xhsBqle";

    oauth_signature = "uaBGwcandamx_kGYem-HojRZIH8";

    search_path = "/v2/search";

    default_location = "toronto";

    api_host = "http://api.yelp.com/v2/search";

    response = void 0;

    yelpAPI.prototype.startSearch = function(location, term) {
      var consumer, oauth, requestData, signature_method, token;
      consumer = {
        "public": oauth_consumer_key,
        secret: oauth_consumer_secret
      };
      token = {
        "public": oauth_token,
        secret: oauth_signature
      };
      signature_method = "HMAC-SHA1";
      oauth = OAuth({
        consumer: consumer,
        signature_method: signature_method
      });
      requestData = {
        url: api_host,
        method: 'GET',
        data: {
          term: term,
          location: location,
          sort: 1
        }
      };
      $.ajax({
        url: requestData.url,
        data: oauth.authorize(requestData, token),
        success: function(data, textStatus, jqXHR) {
          var randomNumber;
          console.log(data);
          response = data;
          randomNumber = Math.floor(Math.random() * 10000000000000000) % 20;
          console.log(randomNumber);
          return ResultBox.show(data.businesses[randomNumber]);
        },
        error: function(jqXHR, textStatus, errorThrown) {
          return console.log(errorThrown);
        }
      });
      if (response) {
        return response;
      } else {
        return "no data";
      }
    };

    return yelpAPI;

  })());

}).call(this);

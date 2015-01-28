coffeeify = require "caching-coffeeify"
coffeeReactify = require "coffee-reactify"

module.exports = (grunt) ->

	grunt.initConfig
    coffee:
      compile:
        files:
          #"./build/game.js": "./scripts/game.cjsx"
          "./build/main.js": "./scripts/main.coffee"

    connect:
      server:
        options:
          port: 3000
          hostname: "*"
          base: "./build/"
    copy:
      base:
        files: [
          expand: yes
          dest: "./build/"
          cwd: "./"
          src: ["*.html","css/*.css"]
        ]
    browserify:
      options:
        transform: [
          coffeeReactify
        ]
      ###
      main:
        src: "./scripts/main.coffee"
        dest: "./build/main.js"
      ###
      game:
        src: "./scripts/game.cjsx"
        dest: "./build/game.js"
        options:
          transform: [
            coffeeReactify
          ]


  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-browserify"

  grunt.registerTask "build", [
    "copy"
    "coffee"
    "browserify"
  ]
  grunt.registerTask "serve", ["connect:server:keepalive"]
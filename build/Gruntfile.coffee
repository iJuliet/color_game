module.exports = (grunt) ->

	grunt.initConfig
    coffee:
      compile:
        files:
          "./build/main.js": "./main.coffee"

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
          src: ["*.html", "*.coffee","css/*.css"]
        ]

      scripts:
        files: [
          expand: yes
          dest: "./build/scripts/"
          cwd:"./scripts"
          src: ["*.coffee"]
        ]

  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.registerTask "build", [
    "copy"
    "coffee"
  ]
  grunt.registerTask "serve", ["connect:server:keepalive"]
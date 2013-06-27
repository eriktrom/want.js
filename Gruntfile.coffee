module.exports = (grunt) ->
  require('matchdep')
    .filterDev('grunt-*')
    .filter((name) -> name isnt 'grunt-cli')
    .forEach(grunt.loadNpmTasks)
  config = (configFileName) ->
    require("./grunt/configurations/#{configFileName}")

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    clean: ["tmp-coffee", "tmp"]
    transpile: config('transpile')
    coffee: config('coffee')
    copy: config('copy')
    concat: config('concat')
    connect: config('connect')
    watch: config('watch')
    karma: config('karma')
    mocha: config('mocha')

  grunt.registerTask 'build', [
    'clean'
    'transpile'
    'coffee'
    'copy'
    'concat'
  ]

  grunt.registerTask 'server', [
    'build'
    'connect'
    # 'karma:unit'
    'karma:mochaUnit'
    'watch'
  ]

  grunt.registerTask 'test', [
    'build'
    'connect'
    'mocha'
  ]
module.exports = (grunt) ->
  require('matchdep')
    .filterDev('grunt-*')
    .filter((name) -> name isnt 'grunt-cli')
    .forEach(grunt.loadNpmTasks)

  grunt.loadTasks('./grunt/tasks')

  config = (configFileName) ->
    require("./grunt/configurations/" + configFileName)

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    clean: ["tmp*", "dist"]
    transpile: config('transpile')
    coffee: config('coffee')
    jshint: config('jshint')
    copy: config('copy')
    concat: config('concat')
    connect: config('connect')
    watch: config('watch')
    qunit: config('qunit')
    karma: config('karma')
    browser: config('browser')
    buildTests: config('buildTests')

  grunt.registerTask 'build', [
    'clean'
    'transpile'
    'coffee'
    'jshint'
    'copy'
    'concat'
    'browser'
    'buildTests'
  ]

  grunt.registerTask 'server', [
    'build'
    'connect'
    'karma:unit'
    'watch'
  ]

  grunt.registerTask 'test', [
    'build'
    'connect'
    'qunit'
  ]
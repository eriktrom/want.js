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
    browser: config('browser')

    buildTests: config('buildTests')
    connect: config('connect')
    watch: config('watch')
    qunit: config('qunit')
    karma: config('karma')


  grunt.registerTask 'build', [
    'clean'
    'copy' # only copies test/public/index.html and test/public/vendor, move into test only build chain
    'transpile'
    'coffee'
    'jshint'
    'concat'
    'browser'
  ]

  grunt.registerTask 'server', [
    'build'
    'buildTests'
    'connect'
    'karma:unit'
    'watch'
  ]

  grunt.registerTask 'test', [
    'build'
    'buildTests'
    'connect'
    'qunit'
  ]
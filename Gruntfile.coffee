module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

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
    'karma:unit'
    'karma:mochaUnit'
    'watch'
  ]
module.exports = (grunt) ->
  config =
    pkg: grunt.file.readJSON('package.json')
    clean: ["tmp*", "dist"]

  grunt.util._.extend(config, loadConfig('./grunt/configurations/'))
  grunt.initConfig(config)

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)
  grunt.loadTasks('./grunt/tasks')

  grunt.registerTask 'build', [
    'clean'
    'transpile'
    'coffee'
    'jshint'
    'concat'
    'browser'
  ]

  grunt.registerTask 'buildTests', [
    'build'
    'copy:test'
    'browserTests'
  ]

  grunt.registerTask 'server', [
    'buildTests'
    'connect'
    'karma:unit'
    'watch'
  ]

  grunt.registerTask 'test', [
    'buildTests'
    'connect'
    'qunit'
  ]

loadConfig = (path) ->
  string = require('string')
  glob = require('glob')
  object = {}

  glob.sync('*', cwd: path).forEach (option) ->
    key = option.replace(/\.js|\.coffee/, '')
    key = string(key).camelize().s
    object[key] = require(path + option)

  object
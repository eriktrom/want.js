grunt = require('grunt')

nameFor = (path) ->
  modulePrefix = grunt.config.process("<%= pkg.modulePrefix %>")

  mainModule = ->
    if path is modulePrefix
      path + '/main'

  testModule = ->
    if /\_test|test_helper/.test(path)
      # by default, grunt-es6-module compiler removes test from matched path
      matchFromTranspiler = path.match(/^(.*?)(?:\.js|\.coffee)?$/)
      matchFromBuildTests = path.match(/^(?:test)\/(.*?)(?:\.js|\.coffee)?$/)
      match = matchFromBuildTests ? matchFromTranspiler
      modulePrefix + '/test/' + match[1]

  mainModule() || testModule() || path

module.exports = {nameFor}
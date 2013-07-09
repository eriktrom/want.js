grunt = require('grunt')

nameFor = (path) ->
  mainModule = ->
    if path is modulePrefix()
      path + '/main'

  testModule = ->
    if match
      modulePrefix() + '/test/' + match[1]
    else
      modulePrefix() + '/' + path

  modulePrefix = -> grunt.config.process("<%= pkg.modulePrefix %>")
  match = -> path.match(/^(?:lib|test)\/(.*?)(?:\.js|\.coffee)?$/)

  mainModule() || path

module.exports = {nameFor}
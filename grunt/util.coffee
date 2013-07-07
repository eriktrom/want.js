grunt = require('grunt')
module.exports.nameFor = (path) ->
    match = path.match(/^(?:lib|test)\/(.*?)(?:\.js|\.coffee)?$/)
    modulePrefix = grunt.config.process("<%= pkg.modulePrefix %>")
    mainModule =  path + '/main' if path is modulePrefix
    if match
      testModule = modulePrefix + '/test/' + match[1] # goes to name for
    else
      testModule = modulePrefix + '/' + path
    console.log testModule
    mainModule || testModule || path

    # TODO: the requireModule statements in tests.js have an extra 'test/' in them
    # and the define statements in main.js have an extra test in them
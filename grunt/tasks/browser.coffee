browserUtil = require('../browserUtil')

module.exports = (grunt) ->
  grunt.registerMultiTask 'browser', "Export globals.<%= pkg.globalExport %>", ->

    @files.forEach (f) ->
      output = [browserUtil.openScope()]
      output.push.apply(output, f.src.map(grunt.file.read))
      output.push(browserUtil.assignGlobal())
      output.push(browserUtil.closeScope())
      grunt.file.write(f.dest, grunt.template.process(output.join("\n")))
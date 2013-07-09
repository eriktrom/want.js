assignGlobal = require('../util').assignGlobal
openScope = require('../util').openScope
closeScope = require('../util').closeScope

module.exports = (grunt) ->
  grunt.registerMultiTask 'browser', "Export globals.<%= pkg.globalExport %>", ->

    @files.forEach (f) ->
      output = [openScope()]
      output.push.apply(output, f.src.map(grunt.file.read))
      output.push(assignGlobal())
      output.push(closeScope())
      grunt.file.write(f.dest, grunt.template.process(output.join("\n")))
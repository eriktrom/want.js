assignGlobal = require('../util').assignGlobal

module.exports = (grunt) ->
  grunt.registerMultiTask 'browser', "Export window.<%= pkg.globalExport %>", ->

    openScope = '(function(globals) {'
    closeScope = '})(window);'

    @files.forEach (f) ->
      output = [openScope]
      output.push.apply(output, f.src.map(grunt.file.read))
      output.push(assignGlobal())
      output.push(closeScope)
      grunt.file.write(f.dest, grunt.template.process(output.join("\n")))
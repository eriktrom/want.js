module.exports = (grunt) ->
  grunt.registerMultiTask 'browser', "Export window.<%= pkg.globalExport %>", ->

    openScope = '(function(globals) {'
    assignGlobal = 'window.<%= pkg.globalExport %> = requireModule("<%= pkg.modulePrefix %>");'
    closeScope = '})(window);'

    @files.forEach (f) ->
      output = [openScope]
      output.push.apply(output, f.src.map(grunt.file.read))
      output.push(assignGlobal)
      output.push(closeScope)
      grunt.file.write(f.dest, grunt.template.process(output.join("\n")))
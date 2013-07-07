nameFor = require('../util').nameFor

module.exports = (grunt) ->
  grunt.registerMultiTask 'buildTests', "Require the test modules", ->
    testFiles = grunt.file.expand('test/**/*_test.*')

    openScope = '(function(globals) {'
    testHelperFile = "requireModule('<%= pkg.modulePrefix %>/test/test_helper');"
    closeScope = '})(window);'

    @files.forEach (f) ->
      output = [openScope]
      output.push.apply(output, f.src.map(grunt.file.read))
      output.push(testHelperFile)
      testFiles.forEach (testFile) ->
        output.push("requireModule('#{nameFor(testFile)}');")
      output.push(closeScope)
      grunt.file.write(f.dest, grunt.template.process(output.join("\n")))
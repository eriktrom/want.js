nameFor = require('../util').nameFor
assignGlobal = require('../util').assignGlobal
openScope = require('../util').openScope
closeScope = require('../util').closeScope

module.exports = (grunt) ->
  grunt.registerMultiTask 'buildTests', "Require the test modules", ->
    testFiles = grunt.file.expand('test/**/*_test.*')
    testHelperFile = "requireModule('<%= pkg.modulePrefix %>/test/test_helper');"

    @files.forEach (f) ->
      output = [openScope()]
      output.push.apply(output, f.src.map(grunt.file.read))
      output.push(testHelperFile)
      testFiles.forEach (testFile) ->
        output.push("requireModule('#{nameFor(testFile)}');")
      output.push(assignGlobal())
      output.push(closeScope())
      grunt.file.write(f.dest, grunt.template.process(output.join("\n")))
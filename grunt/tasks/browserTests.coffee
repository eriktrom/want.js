browserUtil = require('../browserUtil')

module.exports = (grunt) ->
  grunt.registerMultiTask 'browserTests', "Require the test modules", ->
    testFiles = grunt.file.expand('test/**/*_test.*')
    testHelperFile = "requireModule('<%= pkg.modulePrefix %>/test/test_helper');"

    @files.forEach (f) ->
      output = [browserUtil.openScope()]
      output.push.apply(output, f.src.map(grunt.file.read))
      output.push(testHelperFile)
      testFiles.forEach (testFile) ->
        output.push("requireModule('#{browserUtil.nameFor(testFile)}');")
      output.push(browserUtil.assignGlobal())
      output.push(browserUtil.closeScope())
      grunt.file.write(f.dest, grunt.template.process(output.join("\n")))
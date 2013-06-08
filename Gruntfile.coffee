module.exports = (grunt) ->
  barename = 'want'
  portNumber = 8000

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    clean: ['dist', 'tmp']

    transpile:
      amd:
        type: 'amd'
        src: [
          "lib/#{barename}.coffee"
          "lib/*/**/*.coffee"
        ]
        dest: "tmp/#{barename}.amd.coffee"
      tests:
        type: 'amd'
        src: [
          'test/tests.coffee'
          'test/tests/**/*_test.coffee'
        ]
        dest: 'tmp/tests.amd.coffee'

    concat:
      testDeps:
        src: ['vendor/deps/test/*.js']
        dest: 'tmp/test-deps.js'
      libDeps:
        src: ['vendor/deps/lib/*.js']
        dest: 'tmp/lib-deps.js'

    coffee:
      options:
        bare: true
        join: true
      lib:
        src: ["tmp/#{barename}.amd.coffee"]
        dest: 'dist/<%= pkg.name %>-<%= pkg.version %>.amd.js'
      browser:
        src: [
          'vendor/loader.coffee'
          "tmp/#{barename}.amd.coffee"
        ]
        dest: "tmp/#{barename}.browser1.js"
      prepareTests:
        src: [
          'vendor/loader.coffee'
          'tmp/tests.amd.coffee'
          "tmp/#{barename}.amd.coffee"
        ]
        dest: 'tmp/without-templates-tests.js'
      # NOTE: coffee:prepareTests and coffee:browser do almost the same thing, except that prepare
        # tests adds the tests as well. It would nice if we could use browser1 when running
        # prepare tests, but its not a coffee file, so we duplicate the logic
        #
        # Furthermore, browser:dist and buildTests then almost does the next two steps
        # respectively, and again we duplicate.

    browser:
      dist:
        src: [
          "tmp/lib-deps.js"
          "tmp/#{barename}.browser1.js"
          "tmp/compiled-templates.js"
        ]
        dest: 'dist/<%=pkg.name%>-<%=pkg.version%>.js'

    connect:
      options:
        hostname: '0.0.0.0'
        port: portNumber
        base: '.'
      server: {}

    buildTests:
      dist:
        src: [
          "tmp/test-deps.js"
          'tmp/without-templates-tests.js'
          "tmp/compiled-templates.js"
        ]
        dest: 'tmp/tests.js'

    karma: # TODO: create CI build that gets run with grunt test
      unit:
        configFile: 'karma.conf.js'
        background: true

    watch:
      options:
        livereload: true
      files: [
        'lib/**/*'
        'vendor/**/*'
        'test/**/*'
      ]
      tasks: [
        'build'
        'tests'
        'karma:unit:run'
      ]

    mocha:
      all:
        options:
          urls: ["http://localhost:#{portNumber}/test"]
          run: true


  # 2. Load grunt tasks used above
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-mocha'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-karma'

  # 3. setup some tasks
  grunt.registerTask 'default', ['build']

  grunt.registerTask 'build',
                     'Builds a distributable version of <pkg.name>',
                     ['clean'
                      'transpile:amd'
                      'concat:libDeps'
                      'coffee:lib'
                      'coffee:browser'
                      'browser:dist']

  grunt.registerTask 'test',
                     'Single test run, suitable for CI Server',
                     ['connect'
                      'tests'
                      'mocha']

  grunt.registerTask 'tests',
                     'Builds the test package',
                     ['build'
                      'transpile:tests'
                      'concat:testDeps'
                      'coffee:prepareTests'
                      'buildTests:dist']

  grunt.registerTask 'server',
                     'Run the tests in the browser',
                     ['build'
                      'tests'
                      'connect'
                      'karma:unit'
                      'watch']


  grunt.registerMultiTask 'browser', 'Export object in <%=pkg.name%> to window', ->
    combineAndWrap.call(@, barename)

  grunt.registerMultiTask 'buildTests', 'Execute the tests', ->
    combineAndWrap.call(@, 'tests')

  grunt.registerMultiTask 'transpile', 'Transpile ES6 modules to AMD, CJS, or globals', ->
    Compiler = require('es6-module-transpiler').Compiler
    options = @options
      format: 'amd'
      coffee: true
    @files.forEach (f) ->
      contents = f.src.map (path) ->
        compiler = new Compiler(grunt.file.read(path), nameFor(path), options)
        switch options.format
          when 'amd'
            console.log "Compiling #{path} to AMD"
            format = compiler.toAMD
          when 'globals'
            format = compiler.toGlobals
          when 'cjs'
            format = compiler.toCJS
          else
            throw new Error("Invalid format, use 'amd', 'globals' or 'cjs'")
        format.call(compiler)
      grunt.file.write(f.dest, contents.join("\n\n"))

  nameFor = (path) ->
    console.log(path)
    path.match(/^(?:lib|test|test\/tests)\/(.*)\.coffee$/)[1]

  combineAndWrap = (dependency) ->
    @files.forEach (filepath) ->
      output = ["(function(globals) {"]
      output.push.apply(output, filepath.src.map(grunt.file.read)) # TODO: A: using apply removes the comma that would precede the second file
      output.push("requireModule('#{dependency}');")
      output.push('})(window);')
      grunt.file.write(filepath.dest, output.join("\n"))
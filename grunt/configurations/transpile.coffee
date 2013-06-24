module.exports =
  main:
    type: 'amd'
    moduleName: (defaultModuleName) ->
      "wantjs/#{defaultModuleName}"
    files: [
      expand: true
      cwd: 'lib/'
      src: ['**/*.js']
      dest: "tmp/public/wantjs/"
    ]

  tests:
    type: 'amd'
    files: [
      expand: true
      cwd: 'test/'
      src: ['**/*.coffee']
      dest: 'tmp-coffee/public/test/'
    ]

  mochaTests:
    type: 'amd'
    files: [
      expand: true
      cwd: 'mocha-test/'
      src: ['**/*.coffee']
      dest: 'tmp-coffee/public/mocha-test/'
    ]
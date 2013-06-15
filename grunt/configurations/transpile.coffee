module.exports =
  main:
    type: 'amd'
    moduleName: (defaultModuleName) ->
      "wantjs/#{defaultModuleName}"
    files: [
      expand: true
      cwd: 'lib/'
      src: ['**/*.coffee']
      dest: "tmp-coffee/public/wantjs/"
    ]

  tests:
    type: 'amd'
    files: [
      expand: true
      cwd: 'test/'
      src: ['**/*.coffee']
      dest: 'tmp-coffee/public/test/'
    ]
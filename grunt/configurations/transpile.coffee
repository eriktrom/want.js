browserUtil = require('../browserUtil')

module.exports =
  main:
    type: 'amd'
    moduleName: browserUtil.nameFor
    files: [
      expand: true
      cwd: 'lib/'
      src: ['**/*.js']
      dest: "tmp/lib/"
      ext: ".amd.js"
    ]

  tests:
    type: 'amd'
    moduleName: browserUtil.nameFor
    files: [
      expand: true
      cwd: 'test/'
      src: ['**/*.coffee']
      dest: 'tmp-coffee/test/'
      ext: ".amd.coffee"
    ]
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

  mainCoffee:
    type: 'amd'
    moduleName: browserUtil.nameFor
    files: [
      expand: true
      cwd: 'lib/'
      src: ['**/*.coffee']
      dest: "tmp-coffee/lib/"
      ext: ".amd.coffee"
    ]

  tests:
    type: 'amd'
    moduleName: browserUtil.nameFor
    files: [
      expand: true
      cwd: 'test/'
      src: ['**/*.js']
      dest: 'tmp/test/'
      ext: ".amd.js"
    ]

  testsCoffee:
    type: 'amd'
    moduleName: browserUtil.nameFor
    files: [
      expand: true
      cwd: 'test/'
      src: ['**/*.coffee']
      dest: 'tmp-coffee/test/'
      ext: ".amd.coffee"
    ]
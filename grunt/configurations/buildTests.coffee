module.exports =
  dist:
    src: [
      'vendor/loader.js'
      'tmp/test/test_helper.amd.js'
      'tmp/test/acceptance/**/*.amd.js'
      'tmp/test/unit/**/*.amd.js'
    ]
    dest: 'tmp/public/tests.js'

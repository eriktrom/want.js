module.exports =

  vendor:
    src: [
      'vendor/*.js'
      '!vendor/loader.js'
    ]
    dest: 'tmp/public/vendor.js'

  main:
    src: [
      'vendor/loader.js'
      'tmp/lib/<%= pkg.modulePrefix %>.amd.js'
      'tmp/lib/**/*.amd.js'
    ]
    dest: 'tmp/public/main.amd.js'

  # tests:
  #   src: [
  #     'tmp/test/test_helper.amd.js'
  #     'tmp/test/acceptance/**/*.amd.js'
  #     'tmp/test/unit/**/*.amd.js'
  #   ]
  #   dest: 'tmp/public/tests.amd.js'
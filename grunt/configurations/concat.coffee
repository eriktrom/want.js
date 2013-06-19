module.exports =
  main:
    src: ['tmp/public/wantjs/**/*.js']
    dest: 'tmp/public/want.js'
    options:
      footer: """
        window.Want = requireModule("wantjs/want");
      """

  tests:
    src: ['tmp/public/test/**/*.js']
    dest: 'tmp/public/test.js'
    options:
      footer: """
        requireModule("wantjs/test_helper");
      """

  mochaTests:
    src: ['tmp/public/mocha-test/**/*.js']
    dest: 'tmp/public/mocha-test.js'
    options:
      footer: """
        requireModule("wantjs/mocha_test_helper");
      """
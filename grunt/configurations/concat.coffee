module.exports =
  main:
    src: ['tmp/public/wantjs/**/*.js']
    dest: 'tmp/public/want.js'

  tests:
    src: ['tmp/public/test/**/*.js']
    dest: 'tmp/public/test.js'
    options:
      footer: "requireModule('wantjs/want_test')"
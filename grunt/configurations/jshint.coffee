module.exports =
  all:
    src: [
      'tmp/public/**/*.js'
      '!tmp/public/want.js'
      '!tmp/public/vendor/**'
      '!tmp/public/test.js'
    ]
    options:
      jshintrc: '.jshintrc'
      force: true
module.exports =
  all:
    src: [
      'tmp/lib/**/*.js'
      'tmp/test/**/*.js'
    ]
    options:
      jshintrc: '.jshintrc'
      force: true
module.exports =
  all:
    src: [
      'lib/**/*.js'
      'test/**/*.js'
      '!test/vendor/*.js'
    ]
    options:
      jshintrc: '.jshintrc'
      force: true
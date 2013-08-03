module.exports =
  all:
    src: [
      # TODO: growl at me if I make a jshint error
      'lib/**/*.js'
      'test/**/*.js'
      '!test/vendor/*.js'
    ]
    options:
      jshintrc: '.jshintrc'
      force: true
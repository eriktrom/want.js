module.exports =
  all:
    src: [
      # TODO: change to non tmp location when jshint supports es6 syntax
      # and remove `define` global in jshintrc when doing ^^
      # TODO: growl at me if I make a jshint error
      'tmp/lib/**/*.js'
      'tmp/test/**/*.js'
      '!tmp/test/vendor/*.js'
    ]
    options:
      jshintrc: '.jshintrc'
      force: true
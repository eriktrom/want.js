module.exports =
  all:
    src: [
      # TODO: change to non tmp location when jshint supports es6 syntax
      # TODO: remove `define` global in jshintrc when doing ^^
      'tmp/lib/**/*.js'
      'tmp/test/**/*.js'
      '!tmp/test/vendor/*.js'
    ]
    options:
      jshintrc: '.jshintrc'
      force: true
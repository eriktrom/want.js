module.exports =
  options:
    livereload: true
  files: [
    'Gruntfile.*'
    'lib/**/*'
    'vendor/**'
    'test/**/*'
    'grunt/**/*'
    '.jshintrc'
  ]
  tasks: [
    'buildTests'
    'karma:unit:run'
  ]
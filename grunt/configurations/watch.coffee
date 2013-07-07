module.exports =
  options:
    livereload: true
  files: [
    'Gruntfile.*'
    'lib/**/*'
    'vendor/**'
    'test/**/*'
    'grunt/**/*'
  ]
  tasks: [
    'build'
    'karma:unit:run'
  ]
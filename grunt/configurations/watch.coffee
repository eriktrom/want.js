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
    'buildTests'
    'karma:unit:run'
  ]
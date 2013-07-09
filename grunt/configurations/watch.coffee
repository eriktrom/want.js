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
    'buildTests'
    'karma:unit:run'
  ]
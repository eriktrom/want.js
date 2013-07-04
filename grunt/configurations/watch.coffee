module.exports =
  options:
    livereload: true
  files: [
    'lib/**'
    'vendor/**'
    'test/**'
  ]
  tasks: [
    'build'
    'karma:unit:run'
  ]
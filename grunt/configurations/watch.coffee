module.exports =
  options:
    livereload: true
    nospawn: true
  files: [
    'lib/**'
    'vendor/**'
    'test/**'
  ]
  tasks: [
    'build'
    'karma:unit:run'
  ]
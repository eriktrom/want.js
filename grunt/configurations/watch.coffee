module.exports =
  options:
    livereload: true
  files: [
    'lib/**'
    'vendor/**'
    # 'test/**'
    'mocha-test/**'
  ]
  tasks: [
    'build'
    # 'karma:unit:run'
    'karma:mochaUnit:run'
  ]
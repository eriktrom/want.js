module.exports =
  unit:
    configFile: 'karma.conf.js'
    background: true
  mochaUnit:
    configFile: 'karma-mocha.conf.js'
    background: true
    runnerPort: 9101
    port: 9877
module.exports =
  # TODO: these both have the same source and I want the 2 output files
  # to never diverge from the inputs they use to make sure the code I am testing
  # is always the code I am deploying. I also want to call main.js from the
  # test runner to make new projects easy to generate/setup without the risk
  # of fucking up.
  main:
    src: [
      'vendor/loader.js'
      'tmp/public/main.amd.js'
    ]
    dest: 'tmp/public/main.js'

  dist:
    src: [
      'vendor/loader.js'
      'tmp/public/main.amd.js'
    ]
    dest: 'dist/<%= pkg.name %>.js'
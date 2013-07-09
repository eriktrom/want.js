module.exports =
  dist:
    src: [
      'vendor/loader.js'
      'tmp/public/main.amd.js'
    ]
    dest: 'dist/<%= pkg.name %>.js'
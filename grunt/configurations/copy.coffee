module.exports =
  test:
    files: [
      expand: true
      cwd: "test/"
      src: ["index.html", "vendor/**"]
      dest: "tmp/public/test"
    ]

  dist:
    src: [
      'tmp/public/main.js'
    ]
    dest: 'dist/<%= pkg.name %>.js'
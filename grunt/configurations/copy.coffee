module.exports =
  main:
    files: [
      expand: true
      cwd: "public/"
      src: ["**"]
      dest: "tmp/public/"
    ]

  test:
    files: [
      expand: true
      cwd: "test/"
      src: ["index.html"]
      dest: "tmp/public/test"
    ]

  mochaTest:
    files: [
      expand: true
      cwd: "mocha-test/"
      src: ["index.html"]
      dest: "tmp/public/mocha-test"
    ]

  vendor:
    files: [
      expand: true
      cwd: "vendor"
      src: ["**"]
      dest: "tmp/public/vendor"
    ]
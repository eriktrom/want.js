module.exports =

  test:
    files: [
      expand: true
      cwd: "test/"
      src: ["index.html"]
      dest: "tmp/public/test"
    ]

  vendor:
    files: [
      expand: true
      cwd: "vendor"
      src: ["**"]
      dest: "tmp/public/vendor"
    ]
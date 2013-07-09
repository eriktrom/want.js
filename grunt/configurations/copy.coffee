module.exports =
  test:
    files: [
      expand: true
      cwd: "test/"
      src: ["index.html", "vendor/**"]
      dest: "tmp/public/test"
    ]
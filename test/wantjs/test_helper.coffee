QUnit.config.requireExpects = true
QUnit.config.testTimeout = 30000

requireModule('wantjs/naive_promise_test')
requireModule('wantjs/want_test')
requireModule('wantjs/defer_test')

# this file is is pulled in through the concat.coffee file.
# require all files you want to include in the test suite above
root = global ? window

mocha.setup('bdd')
mocha.checkLeaks()

requireModule('wantjs/mocha_naive_promise_test')
requireModule('wantjs/mocha_want_test')
requireModule('wantjs/mocha_defer_test')

root.expect = chai.expect
root.assert = chai.assert
chai.Assertion.includeStack = true
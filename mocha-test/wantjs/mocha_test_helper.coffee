root = global ? window

mocha.setup('bdd')
mocha.checkLeaks()

requireModule('wantjs/mocha_want_test')

root.expect = chai.expect
root.assert = chai.assert
chai.Assertion.includeStack = true
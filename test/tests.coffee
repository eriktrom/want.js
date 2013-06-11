mocha.setup('bdd')
mocha.checkLeaks()

requireModule "tests/want_test"

globals.expect = chai.expect
globals.assert = chai.assert
chai.Assertion.includeStack = true

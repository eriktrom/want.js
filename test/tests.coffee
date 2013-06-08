mocha.setup('bdd')

requireModule "tests/want_test"

globals.expect = chai.expect
globals.assert = chai.assert
chai.Assertion.includeStack = true

mocha.run()

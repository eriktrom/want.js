mocha.setup('bdd')

globals.expect = chai.expect
globals.assert = chai.assert
chai.Assertion.includeStack = true


########################################
### Start of Feature ###

globals.Feature = (feature, story..., callback) ->
  skip = false
  if feature == false # First arg is false, skip
    feature = story.shift()
    skip = true
  message = 'Feature: ' + feature
  if not callback?
    callback = story.shift()
  else
    message += ' [' + story.join(' ') + ']' # The web reporter will escape all
                                            # HTML, so don't try to format it.
  if skip
    describe.skip message, -> it 'skipped'
  else
    describe message, callback


### Start of Scenario ###

globals.Scenario = (message, callback) ->
  if message == false  # First arg is false, skip
    message = callback
    describe.skip 'Scenario: ' + message, -> it 'skipped'
  else
    describe 'Scenario: ' + message, callback


### Beginning of GWTab ###

gwtIt = (label, message, callback) ->  # routes command to an It
  message = label + message
  if not callback? or callback.toString() == (->).toString()  # If Blank
    it message
  else
    if callback.length
      it message, (done) ->
        try callback.call this, done
        catch e
          this.test.parent.bail(true)
          throw e
    else
      it message, ->
        try callback.call this
        catch e
          this.test.parent.bail(true)
          throw e

createGWTab = (label) ->  # Creates Given, When, Then, and, but commands
  return (message, callback) -> gwtIt label, message, callback

globals.Given = createGWTab('GIVEN ')

globals.When = createGWTab('WHEN ')

globals.Then = createGWTab('THEN ')

globals.And = createGWTab('...and ')

globals.But = createGWTab('...but ')

#########################################
requireModule "tests/want_test"
mocha.run()

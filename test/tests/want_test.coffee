import Want from "want"
import "tests" as globals

describe "Want", ->
  it "should be a function", ->
    expect(Want).to.be.a "function"

  it "a function can't return a value immediately", ->
    clock = sinon.useFakeTimers();
    callbackSpy = sinon.spy()
    oneOneSecondLater = (callback) ->
      setTimeout ->
        callback(1)
      , 1000

    oneOneSecondLater(callbackSpy)
    clock.tick(1000)
    assert callbackSpy.calledOnce

    clock.restore()






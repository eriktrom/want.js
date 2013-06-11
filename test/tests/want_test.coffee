import "want" as Want

describe "Want", ->
  it "should be an object", ->
    expect(Want).to.be.a "object"
    # expect(Want).to.be.an.instanceof Want

  it "a function can't return a value immediately", ->
    clock = sinon.useFakeTimers();
    callbackSpy = sinon.spy()

    Want.oneOneSecondLater(callbackSpy)

    clock.tick(1000)
    assert callbackSpy.calledOnce

    clock.restore()

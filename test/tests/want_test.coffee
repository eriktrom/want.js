
oneOneSecondLater = (callback) ->
  setTimeout ->
    callback(1)
  , 1000


describe "oneOneSecondLater", ->
  beforeEach -> @clock = sinon.useFakeTimers()
  afterEach -> @clock.restore()
  it "calls the callback with an arg of 1 after 1000ms", ->
    callback = sinon.spy()
    oneOneSecondLater(callback)
    @clock.tick(999)
    assert callback.notCalled
    @clock.tick(1)
    assert callback.calledWith(1)


maybeOneOneSecondLater = (callback, errback) ->
  setTimeout ->
    if Math.random < .5
      callback(1)
    else
      errback(new Error("Can't provide one."))
  , 1000

describe "maybeOneOneSecondLater", ->
  beforeEach -> @clock = sinon.useFakeTimers()
  afterEach -> @clock.restore()
  it "calls the errback with an error when stubbing Math.random", ->
    sinon.stub(Math, "random").returns(.6)
    callback = sinon.spy()
    errback = sinon.spy()
    maybeOneOneSecondLater(callback, errback)
    @clock.tick(1000)
    assert callback.notCalled
    assert errback.calledWith(new Error("Can't provide one."))

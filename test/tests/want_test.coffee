
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
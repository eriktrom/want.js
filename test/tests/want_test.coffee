
describe "The general idea of a promise through the use of setTimeout", ->

  beforeEach -> @clock = sinon.useFakeTimers()
  afterEach -> @clock.restore()

  describe "oneOneSecondLater", ->

    oneOneSecondLater = (callback) ->
      setTimeout ->
        callback(1)
      , 1000

    it "calls the callback with an arg of 1 after 1000ms", ->
      callback = sinon.spy()
      oneOneSecondLater(callback)
      @clock.tick(999)
      assert callback.notCalled
      @clock.tick(1)
      assert callback.calledWith(1)

  describe "maybeOneOneSecondLater", ->

    maybeOneOneSecondLater = (callback, errback) ->
      setTimeout ->
        if Math.random < .5
          callback(1)
        else
          errback(new Error("Can't provide one."))
      , 1000

    it "calls the errback with an error when stubbing Math.random", ->
      sinon.stub(Math, "random").returns(.6)
      callback = sinon.spy()
      errback = sinon.spy()
      maybeOneOneSecondLater(callback, errback)
      @clock.tick(1000)
      assert callback.notCalled
      assert errback.calledWith(new Error("Can't provide one."))

    it "Can't provide an error", -> # line 61


describe "The slow implementation of a real promise", ->
  describe "maybeOneOneSecondLater", ->

    maybeOneOneSecondLater = ->
      then: ->

    it "returns an object with a 'then' method", ->
      expect(maybeOneOneSecondLater()).to.respondTo('then')
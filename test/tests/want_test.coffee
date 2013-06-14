
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
      # given
      sinon.stub(Math, "random").returns(.6)
      callback = sinon.spy()
      errback = sinon.spy()
      # when
      maybeOneOneSecondLater(callback, errback)
      @clock.tick(1000)
      # then
      assert callback.notCalled
      assert errback.calledWith(new Error("Can't provide one."))

      Math.random.restore()

    it "Can't provide an error" # line 61
      # sinon.stub(Math, "random").returns(.6)
      # callback = ->
      # errback = ->
      # expect(maybeOneOneSecondLater(callback, errback)).to.throw(Error)
      # TODO: is this already fully tested, or do I need something like the above?
      # I might want something like the above to understand what the q/design/README, line 61 is talking about

describe "The slow implementation of a pseudo promise", ->
  describe "maybeOneOneSecondLater", ->

    maybeOneOneSecondLater = ->
      callback = null
      setTimeout ->
        callback(1)
      , 1000
      then: (_callback) ->
        callback = _callback

    it "returns an object with a 'then' method", ->
      sinon.stub(window, "setTimeout")
      expect(maybeOneOneSecondLater()).to.respondTo('then')
      window.setTimeout.restore()

    describe ".then", ->

      beforeEach ->
        @clock = sinon.useFakeTimers()
        @callback = sinon.spy()

      afterEach ->
        @clock.restore()

      it "registers a callback", ->
        maybeOneOneSecondLater().then(@callback)
        @clock.tick(999)
        assert.ok @callback.notCalled
        @clock.tick(1)
        assert.ok @callback.calledWith(1)

      context "when callback is registered more than a second after promise was constructed", ->
        specify "a passing test in this format", ->
          promise = maybeOneOneSecondLater()
          @clock.tick(999)
          promise.then(@callback)
          expect(@callback).not.to.have.been.called
          @clock.tick(1)
          expect(@callback).to.have.been.called
        specify "failing b/c 1000ms have passed before registering callback", ->
          maybeOneOneSecondLater()
          try
            @clock.tick(1000)
          catch e
            expect(e.message).to.eq 'object is not a function'

    # describe ".then not using timers", ->
    #   # @timeout(2000)
    #   it.skip "registers a callback", (done) ->
    #     callback = sinon.spy()
    #     maybeOneOneSecondLater().then(callback)
    #     # assert.ok callback.calledWith(1)
    #     # sinon.assert.calledWith(callback, 1)
    #     expect(callback).to.have.been.calledWith(1)
    #     done()


describe "making the pseudo promise a two state object", ->

  maybeOneOneSecondLater = ->
    pendingCallbacks = []
    value = null
    setTimeout ->
      value = 1
      for callback in pendingCallbacks
        callback(value)
      pendingCallbacks = null
    , 1000
    then: (callback) ->
      if pendingCallbacks
        pendingCallbacks.push(callback)
      else
        callback(value)

  beforeEach -> @clock = sinon.useFakeTimers()
  afterEach -> @clock.restore()

  specify "when the promise is resolved, all the observers are notified", ->
    callback1 = sinon.spy()
    callback2 = sinon.spy()

    promise = maybeOneOneSecondLater()
    promise.then(callback1)
    promise.then(callback2)
    @clock.tick(1000)

    expect(callback1).to.have.been.calledWith(1)
    expect(callback2).to.have.been.calledWith(1)

  specify "not failing even after 1000ms have passed(fixes previous fail)", ->
    maybeOneOneSecondLater()
    @clock.tick(1000)

  specify "after the promise is resolved, new callbacks are called immediately", ->
    callback = sinon.spy()
    promise = maybeOneOneSecondLater()
    @clock.tick(1000)
    promise.then(callback)
    expect(callback).to.have.been.calledWith(1)

describe "defer", ->

  defer = ->
    resolve: ->
    then: ->

  it "is a function", ->
    assert.isFunction(defer)
  it "it returns an object with a 'resolve' method", ->
    assert.isFunction defer().resolve
  it "returns an object with a 'then' method", ->
    assert.isFunction defer().then

  describe ".resolve", ->
    it "notifies observers of resolution", ->
      ok false
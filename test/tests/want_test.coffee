
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

describe "The slow implementation of a real promise", ->
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
      window.setTimeout.restore() # to prevent console error when callback is called, which happened when we added setTimeout block to the function

    describe ".then", ->
      beforeEach -> @clock = sinon.useFakeTimers()
      afterEach -> @clock.restore()
      it "registers a callback", ->
        callback = sinon.spy()
        maybeOneOneSecondLater().then(callback)
        @clock.tick(999)
        assert callback.notCalled
        @clock.tick(1)
        assert callback.calledWith(1)

      context "when callback is registered more than a second after promise was constructed", ->
        specify "the callback won't be called" # TODO, line 112

    describe ".then not using timers", ->
      # @timeout(2000)
      it.skip "registers a callback", (done) ->
        callback = sinon.spy()
        maybeOneOneSecondLater().then(callback)
        # assert.ok callback.calledWith(1)
        # sinon.assert.calledWith(callback, 1)
        expect(callback).to.have.been.calledWith(1)
        done()

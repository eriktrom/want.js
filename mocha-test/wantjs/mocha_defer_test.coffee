import { defer, isPromise, ref, reject } from "wantjs/defer"

describe "defer", ->
  it "is a function", ->
    assert.isFunction defer

  it "returns an object", ->
    assert.isObject defer()

  it "returns an object with a 'resolve' method", ->
    assert.isFunction defer().resolve

describe "defer().promise", ->
  it "is an object", ->
    assert.isObject defer().promise

  it "it has a 'then' method", ->
    assert.isFunction defer().promise.then

describe "isPromise", ->
  it "returns true when given an object with a 'then' method", ->
    assert.ok isPromise({then: ->})
  it "returns false when given an object WITHOUT a 'then' method", ->
    assert.ok !isPromise('Just a value')

describe "Composable Promises", ->

  specify "The 'then' method must return a promise", ->
    onFulfilledCallback = (value) -> value
    aPromise = defer().promise.then(onFulfilledCallback)
    assert.ok isPromise(aPromise)

  specify """The returned promise must be eventually resolved with the return
  value of the callback"""
    # assert.ok aPromise.should_receive(:resolve).with(onFulfilledCallback.firstArg)

  specify """The return value of the callback must be either a fulfilled value or
  a promise"""
    # how do you know if something is a fulfilled value? it's the value returned
    # by the onFulfilled callback?

  specify "Integration test using composable promises", (done) ->

    oneOneSecondLater = ->
      result = defer()
      setTimeout ->
        result.resolve(1)
      , 1000
      result#.promise <-- passes test

    a = oneOneSecondLater()
    b = oneOneSecondLater()
    c = a.then (a) ->
      b.then (b) ->
        expect(a + b).to.eq 2
        done()

describe "ref", ->

  it "converts a value into a promise", ->
    aPromise = ref("Just a value")
    assert.ok isPromise(aPromise)

  it "informs any observers that the value has already been fulfilled", ->
    onFulfilledCallback = sinon.spy()
    ref("Just a value").then(onFulfilledCallback)
    assert.ok onFulfilledCallback.calledWith("Just a value")

  it "does not inform observers if the value is already a promise", ->
    onFulfilledCallback = sinon.spy()
    ref({then: ->}).then(onFulfilledCallback)
    expect(onFulfilledCallback.callCount).to.eq 0

  context "when 'onFulfilledCallback' is passed an arg value that is not a promise", ->
    it """should coerce the RETURN value 'onFulfilledCallback' into a promise and
       return it immediately""", ->
      onFulfilledCallback = (value) -> value
      result = ref("Just a value").then(onFulfilledCallback)
      assert.ok isPromise(result)

  context "when 'onFulfilledCallback' is already given promise as arg value", ->
    it "should NOT modify the given arg value", ->
      onFulfilledCallback = (value) ->
        expect(value).to.eq aPromise
      aPromise = {then: ->}
      ref(aPromise).then(onFulfilledCallback)

  # NOTE: it's a bit inconsisent the way the two above tests have to be formatted.
  # I guess it's to be expected with the current implementation though
  #
  # In the first several tests, we are checking that ref converts a value into
  # a promise. Once it does this, the value has it's own implementation of 'then'
  # and passes the value given to ref into the onFulfilledCallback immediately,
  # thus, we check test it with result = ..., then check result
  #
  # In the second context, we are testing then as it's implemented in inside
  # defer, which I am still not quite clear on how it works, yada..

describe "resolve", ->

  # context "when given a ref promise as value arg", ->
  # context "when given a deferred promise as value arg", ->


  # TODO: we pass a value or a promse to resolve.
  #
  # If we pass a value, 'ref' will wrap the value and turn it into a promise.
  #
  # If we pass a promise, ref does nothing and returns the promise, as given
  #
  # Regardless, resolve calls value.then(callback) instead of callback(value).
  #
  # The value returned by the callback will resolve the promise returned by then

  # Furthermore, resolve needs to handle the case where the resolution is itself
  # a promise to resolve later. This is accomplished by changing the resolution
  # value to a promise.
  #
  # It can be a promise returned by defer or a promise returned by ref
  #
  # If it's a promise returned by ref, the callback is called immediately
  #
  # If it's a promise returned by defer, the callback is passed forward to the
  # next promise by calling "then(callback)" --
  # -- Thus, in this case, the callback
  # is now observing a new promise for a more fully resolved value, and can be
  # forwarded many times, making progress towards an eventual resolution with
  # each forwarding

describe "reject", ->

  it "is a function", ->
    assert.isFunction reject

  it "has a then method", ->
    assert.isFunction reject().then

  it "informs the errback of its rejection with a reason", (done) ->
    reject("Rejection reason").then (value) ->
      assert.ok false, "Should never reach here"
    , (reason) ->
      expect(reason).to.eq "Rejection reason"
      done()

import { defer, isPromise, ref } from "wantjs/defer"

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
    aPromise = {then: ->}
    expect(isPromise(aPromise)).to.eq true
  it "returns false when given an object without a 'then' method", ->
    expect(isPromise('Hi, just a value')).to.eq false

describe "Composable Promises", ->
  specify "The 'then' method must return a promise"

  specify """The returned promise must be eventually resolved with the return
  value of the callback"""

  specify """The return value of the callback must be either a fulfilled value or
  a promise"""

  specify "Integration test using composable promises", (done) ->

    oneOneSecondLater = ->
      result = defer()
      setTimeout ->
        result.resolve(1)
      , 1000
      result.promise

    a = oneOneSecondLater()
    b = oneOneSecondLater()
    c = a.then (a) ->
      b.then (b) ->
        expect(a + b).to.eq 2
        done()

describe "ref", ->

  it "converts a value into a promise", ->
    aValue = "Just a value"
    expect(isPromise(aValue)).to.eq false
    aPromise = ref(aValue)
    expect(isPromise(aPromise)).to.eq true

  it """should convert a value into a promise that is already fulfilled and informs
  any observers that the value has already been fulfilled""", ->
    onFulfilledCallback = sinon.spy()
    ref("Just a value").then(onFulfilledCallback)
    assert.ok onFulfilledCallback.calledWith("Just a value")

  specify "if the value is already a promise, 'ref' does not inform observers", ->
    onFulfilledCallback = sinon.spy()
    ref({then: ->}).then(onFulfilledCallback)
    expect(onFulfilledCallback.callCount).to.eq 0

  specify "'then' should coerce the return value of its callback into a promise", ->
    onFulfilledCallback = (value) -> value
    result = ref("Just a value").then(onFulfilledCallback)
    assert.ok isPromise(result)

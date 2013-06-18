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

  specify "Integration test using composable promises"

describe "ref", ->
  it "converts a value into a promise", ->
    aValue = "Just a value"
    expect(isPromise(aValue)).to.eq false
    aPromise = ref(aValue)
    expect(isPromise(aPromise)).to.eq true
  it """should convert a value into a promise that is already fulfilled and informs
  any observers that the value has already been fulfilled""", (done) ->
    callback = (value) ->
      expect(value).to.eq "Just a value"
      done()

    ref("Just a value").then(callback)
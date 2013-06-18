import { defer, isPromise } from "wantjs/defer"

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
    aPromise = defer().promise
    expect(isPromise(aPromise)).to.eq true
  it "returns false when given an object without a 'then' method", ->
    aValue = 'Hi, just a value'
    expect(isPromise(aValue)).to.eq false

import { defer, isPromise } from "wantjs/defer"

describe "defer", ->
  it "is a function", ->
    assert.isFunction defer

  it "returns an object", ->
    assert.isObject defer()

  it "returns an object with a 'resolve' method", ->
    assert.isFunction defer().resolve

  it "returns an object with a 'promise' property, that has a 'then' method", ->
    assert.isFunction defer().promise.then

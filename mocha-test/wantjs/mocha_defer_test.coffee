import "wantjs/defer" as defer

describe "defer", ->
  it "is a function", ->
    assert.isFunction defer

  it "returns an object", ->
    assert.isObject defer()

  it "returns an object with a 'resolve' method", ->
    assert.isFunction defer().resolve

  it "returns an object with 'then' method", ->
    assert.isFunction defer().then

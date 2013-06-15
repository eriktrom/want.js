import 'wantjs/want' as wantPromise

describe "wantPromise", ->

  it "is a function", ->
    assert.isFunction wantPromise

  it "returns an object with a then method", (done) ->
    wp = wantPromise()

    setTimeout ->
      done()
    , 1001

    wp.then (value) ->
      assert.isObject wp

  it """observes a promise using the 'then' method.
        When the promise is fulfilled, 'callback' gets called""", (done) ->
    callback = (value) ->
      expect(value).to.eq "hello"
      done()

    wantPromise().then(callback)
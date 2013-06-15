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

  # specify "when the promise is resolved, all of the observers are notified", (done) ->
  #   callback1 = (value) ->
  #     expect(value).to.eq "hello"
  #     callback1Called = true

  #   callback2 = (value) ->
  #     expect(value).to.eq "hello"
  #     callback2Called = true
  #     done()

  #   wp = wantPromise()
  #   wp.then(callback1)
  #   wp.then(callback2)
  #   assert.ok false, "this test should be passing now, but it was also passing
  #                     before the implementation, and therefore is just shitty"
    # assert.ok false, "this test erroneously passes without this fail"
    # This test is currently lying to me. It's telling me everything works, but
      # b/c I'm a dumbass, and async code is hard, at least the qunit version did
      # not wrongfully pass, b/c it expected 2. To accurately test this like it is
      # I either need to use a spy or setup a strange setTimeout up like in the
      # 2nd test, but that then goes back to testing time explicitly. Am I missing
      # something or is qunit just easier to use?

  # it "when the promise is resolved, all the observers are notified (use sinon)", (done) ->
  #   assert.ok false, "figure out a nice way to do this in mocha with sinon"
  #   done()
import 'wantjs/want' as wantPromise

module "wantPromise"

test "is a function", ->
  ok typeof wantPromise is 'function'
  expect 1

test "returns an object", ->
  ok typeof wantPromise() is 'object'
  expect 1

test "has a 'then' method", ->
  ok typeof wantPromise().then is 'function'
  expect 1

asyncTest """observe a promise using the 'then' method.
            When the promise is fulfilled, 'callback' gets called""", ->
  callback = (value) ->
    equal value, "hello"
    start()

  wantPromise().then(callback)
  expect 1
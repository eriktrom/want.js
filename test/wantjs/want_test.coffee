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


# asyncTest "then - want fulfilled, return value", ->
#   wantPromise()
#   .then (value) ->
#     equal value, "hello I am your promised value, hear me roar"
#     start()

#   expect 1
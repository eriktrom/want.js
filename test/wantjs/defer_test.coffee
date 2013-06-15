import { defer, isPromise, ref } from "wantjs/defer"

module "defer"
test "its a function that returns an object a 'resolve' method", ->
  expect 3
  ok typeof defer is "function", "is a function"
  ok typeof defer() is "object", "returns an object"
  ok typeof defer().resolve is "function",
                               "returns an object with a 'resolve' method"

test """it returns a promise as an object which has a
'then' method(principle of least authority refactoring)""", ->
  expect 2
  promise = defer().promise
  ok typeof promise is "object"
  ok typeof promise.then is "function"


module "defer().resolve(value)"
asyncTest "it notifies observers of resolution", ->
  expect 1
  aPromise = ->
    result = defer()
    setTimeout ->
      result.resolve("Promise kept, I am returned value")
    , 1000
    result.promise

  callback = (value) ->
    equal value, "Promise kept, I am returned value",
      "should provide promised value"
    start()

  aPromise().then(callback)

asyncTest """it does not have the flaw where it can be called multiple times
  thereby changing the value of the promised result""", ->
  expect 1
  aPromise = ->
    result = defer()
    setTimeout ->
      result.resolve("Promise kept, I am returned value")
      result.resolve("What happens now")
    , 1000
    result.promise

  aPromise()
  .then (value) ->
    equal value, "Promise kept, I am returned value",
          "should provide promised value"
    start()

module """Distinguish promises from other values by it's 'then' method (ducktyping
          vs Prototype based typing"""
test "isPromise - returns true when passed a value that responds to 'then'", ->
  expect 1
  result = defer().promise
  equal isPromise(result), true


module "defer().promise.then"
# test "it must return a promise"
# test "the return value of the promise must be eventually resolved
#       with the return value of the callback"
# test "the return value of the callback must be either a fulfilled value or a promise"

module """ref - alters 'then' methods so they return promises for the return value
        of their given callback"""
test "it can coerce any argument into a promise regardless of whether it is a
      value or a promise already", ->
  expect 1
  justAValue = 'good'
  ok typeof ref(justAValue).then is "function"

# module "Compose promises - make new promises using values obtained from old promises"
# asyncTest "create a promise for the sum of two numbers that themselves are promises", ->
#   expect 1
#   a = futureNumberValue()
#   b = futureNumberValue()
#   c = a.then (a) ->
#     b.then (b) ->
#       equal a + b, 2
#       start()
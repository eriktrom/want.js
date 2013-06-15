import "wantjs/defer" as defer

module "defer"
test "its a function that returns an object with 2 methods - resolve & then", ->
  expect 4
  ok typeof defer is "function", "is a function"
  ok typeof defer() is "object", "returns an object"
  ok typeof defer().then is "function", "returns an object with 'then' method"
  ok typeof defer().resolve is "function",
                               "returns an object with a 'resolve' method"


# asyncTest "then - it registers observers", ->
#   start()
module "defer().resolve(value)"
asyncTest "it notifies observers of resolution", ->
  expect 1
  aPromise = ->
    result = defer()
    setTimeout ->
      result.resolve("Promise kept, I am returned value")
    , 1000
    result

  callback = (value) ->
    equal value, "Promise kept, I am returned value",
      "should provide promised value"
    start()

  aPromise().then(callback)

# asyncTest """it does not have the flaw where it can be called multiple times
#           thereby changing the value of the promised result""", ->
#   expect 1
#   aPromise = ->
#     result = defer()
#     setTimeout ->
#       result.resolve("Promise kept, I am returned value")
#       result.resolve("What happens now")
#     , 1000
#     result

#   callback = (value) ->
#     start()

#   throws ->
#     aPromise().then(callback)
#   , "A promise can only be resolved once."

asyncTest "ignore rather than throw an error when resolve is called twice", ->
  expect 1
  aPromise = ->
    result = defer()
    setTimeout ->
      result.resolve("Promise kept, I am returned value")
      result.resolve("What happens now")
    , 1000
    result

  callback = (value) ->
    start()

  ok aPromise().then(callback)


# NOTE: qunit has no way to make a test pending
# NOTE: the clarity of mocha + chai is appealing at this stage
# NOTE: qunit has is a bit strange in that you really only provide sentences
# for assertions as they pertain to the error message. You don't see the
# assertion description by defualt unless you click on a test. Mocha on the other
# hand has a fluid assertion style that makes it so clear all around.
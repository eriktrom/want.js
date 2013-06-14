module "naive promise"

test "randomSecondsTillFuture - is an integer less than min, greater than max", ->
  min = 4
  max = 1000

  ok randomSecondsTillFuture(min, max) < 1000
  ok randomSecondsTillFuture(min, max) > 4

  knownInteger = randomSecondsTillFuture(min, max)
  equal knownInteger + Math.floor(0.95), knownInteger, "should be an integer"

  expect 3

asyncTest "wantedValueInFuture", ->
  expect 1
  wantedValueInFuture (value) ->
    equal value, 1
    start()

# asyncTest "maybeOneOneSecondLater", ->
#   expect 1
#   ok window.console.log(Math.random * 100)
#   start()

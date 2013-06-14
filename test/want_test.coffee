module "naive promise"

asyncTest "oneOneSecondLater", ->
  expect 1
  oneOneSecondLater (returnValue) ->
    equal returnValue, 1
    start()

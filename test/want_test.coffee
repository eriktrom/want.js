module "naive promise"

asyncTest "oneOneSecondLater", ->
  expect 1
  oneOneSecondLater (value) ->
    equal value, 1
    start()
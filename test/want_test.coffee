module "naive promise"

test "randomSecondsTillFuture - is an integer less than min, greater than max", ->
  min = 4
  max = 1000

  ok randomSecondsTillFuture(min, max) < 1000
  ok randomSecondsTillFuture(min, max) > 4

  knownInteger = randomSecondsTillFuture(min, max)
  equal knownInteger + Math.floor(0.95), knownInteger, "should be an integer"

  expect 3

asyncTest "wantValueInFuture - is fulfilled", ->
  wantValueInFuture (value) ->
    equal value, 1
    start()

  expect 1

asyncTest "wantValueOrFailReasonInFuture - is fulfilled", ->
  sinon.stub(Wanted, "didHappen").returns(true)

  wantValueInFuture (value) ->
    equal value, 1
    start()

  expect 1


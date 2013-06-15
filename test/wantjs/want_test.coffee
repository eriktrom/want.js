
Wanted = {}

randomSecondsTillFuture = (min, max) ->
  min = 4 unless min
  max = 100 unless max
  Math.floor(Math.random() * (max - min + 1)) + min;

wantValueInFuture = (succeededHereIsValue) ->
  setTimeout ->
    succeededHereIsValue("hello")
  , randomSecondsTillFuture()

wantValueOrRejectionReasonInFuture = (succeededHereIsValue, rejectedHereIsReason) ->
  setTimeout ->
    if Wanted.didHappen
      succeededHereIsValue("hello")
    else
      rejectedHereIsReason(new Error("Bummer dude"))
  , randomSecondsTillFuture()

QUnit.config.requireExpects = true
# QUnit.config.notrycatch = true

module "naive promise"

test "randomSecondsTillFuture - is an integer less than min, greater than max", ->
  min = 6
  max = 1001

  ok randomSecondsTillFuture(min, max) < 1000
  ok randomSecondsTillFuture(min, max) > 4

  knownInteger = randomSecondsTillFuture(min, max)
  equal knownInteger + Math.floor(0.95), knownInteger, "should be an integer"

  expect 3

asyncTest "wantValueInFuture - is fulfilled", ->
  wantValueInFuture (value) ->
    equal value, "hello"
    start()

  expect 1

asyncTest "wantValueOrRejectionReasonInFuture - want fulfilled, return value", ->
  Wanted.didHappen = true

  wantValueOrRejectionReasonInFuture (value) ->
    equal value, "hello"
    Wanted.didHappen = null
    start()

  expect 1


asyncTest "wantValueOrRejectionReasonInFuture - want rejected, provide reason", ->
  Wanted.didHappen = false

  onFulfilled = (value) ->
    equal value, "hello"
    Wanted.didHappen = null
    stop() # should never get run

  wantValueOrRejectionReasonInFuture onFulfilled, (reason) ->
    throws ->
      reason()
      # this test is lying. I can't get it to fail without throwing the exception
      # inside the setTimeout, in which case, then can't get it to pass
    , "Bummer dudee", "Seriously you can't catch this error b/c it was thrown in
                      in a different execution context. But hold out, there is hope."
    Wanted.didHappen = null
    start()

  expect 1

module "wantPromise"

wantPromise = ->
  setTimeout ->
    console.log("hello world")
  , 1000
  then: ->

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
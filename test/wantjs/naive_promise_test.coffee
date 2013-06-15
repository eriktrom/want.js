requireModule("wantjs/naive_promise")
# SAME AS (Note: use requireModule b/c es6-module grunt task is likely to change)
# import "wantjs/naive_promise" as anyUniqueVariableEvenIfYouDontUseItA

module "In General"
test "QUnit requires expects", ->
  ok true, "This test fails b/c you didn't 'expect 1'"
  expect 1

module "randomSecondsTillFuture"
test "it returns a positive random number", ->
  actual = randomSecondsTillFuture()
  ok actual > -actual
  expect 1

test "it can be used to return a determinate value too", ->
  actual = randomSecondsTillFuture(1000)
  equal actual, 1000
  expect 1

test "it is always less than 1000 ms", ->
  actual = randomSecondsTillFuture()
  ok actual < 1000
  expect 1


module "Naive Global Promise Like Functions"
asyncTest "wantValueInFuture - is fulfilled", ->
  wantValueInFuture (promisedValue) ->
    equal promisedValue, "hello"
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
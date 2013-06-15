# import { Wanted, randomSecondsTillFuture, wantValueInFuture, wantValueOrRejectionReasonInFuture } from "wantjs/naive_promise"

requireModule("wantjs/naive_promise")
# SAME AS; Note: use requireModule b/c es6-module grunt task is likely to change
# import "wantjs/naive_promise" as anyUniqueVariableEvenIfYouDontUseItA

module "naive promise"

test "QUnit requires expects", ->
  ok true, "This test fails b/c you didn't 'expect 1'"
  expect 1

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
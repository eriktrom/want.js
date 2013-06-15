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
  return {
    then: (_callback) ->
      succeededHereIsValue = _callback
  }

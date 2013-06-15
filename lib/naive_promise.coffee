globals = window

globals.Wanted = {}

globals.randomSecondsTillFuture = (min, max) ->
  min = 4 unless min
  max = 100 unless max
  Math.floor(Math.random() * (max - min + 1)) + min;

globals.wantValueInFuture = (succeededHereIsValue) ->
  setTimeout ->
    succeededHereIsValue("hello")
  , randomSecondsTillFuture()

globals.wantValueOrRejectionReasonInFuture = (succeededHereIsValue, rejectedHereIsReason) ->
  setTimeout ->
    if Wanted.didHappen
      succeededHereIsValue("hello")
    else
      rejectedHereIsReason(new Error("Bummer dude"))
  , randomSecondsTillFuture()

# look mah, no export!
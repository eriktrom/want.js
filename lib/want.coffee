Wanted =
  didHappen: ->

randomSecondsTillFuture = (min, max) ->
  Math.floor(Math.random() * (max - min + 1)) + min;

wantValueInFuture = (succeededHereIsValue) ->
  setTimeout ->
    succeededHereIsValue(1)
  , randomSecondsTillFuture

wantValueOrFailReasonInFuture = (succeededHereIsValue, failedHereIsReason) ->
  setTimeout ->
    if Wanted.didHappen
      succeededHereIsValue(1)
    else
      failedHereIsReason(new Error("Bummer dude"))

randomSecondsTillFuture = (min, max) ->
  Math.floor(Math.random() * (max - min + 1)) + min;

wantedValueInFuture = (nowFutureSoHereIsWantedValue) ->
  setTimeout ->
    nowFutureSoHereIsWantedValue(1)
  , randomSecondsTillFuture

# maybeOneOneSecondLater = (onFulfilled, onRejection) ->
#   setTimeout ->
#     if
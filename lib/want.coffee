randomSecondsTillFuture = (min, max) ->
  Math.floor(Math.random() * (max - min + 1)) + min;

oneOneSecondLater = (onFulfilled) ->
  setTimeout ->
    onFulfilled(1)
  , 4

# maybeOneOneSecondLater = (onFulfilled, onRejection) ->
#   setTimeout ->
#     if
oneOneSecondLater = (onFulfilled) ->
  setTimeout ->
    onFulfilled(1)
  , 4
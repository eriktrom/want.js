do (root = global ? window) ->

  root.Wanted = {}

  root.randomSecondsTillFuture = (min, max) ->
    min = 4 unless min
    max = 100 unless max
    Math.floor(Math.random() * (max - min + 1)) + min;

  root.wantValueInFuture = (succeededHereIsValue) ->
    setTimeout ->
      succeededHereIsValue("hello")
    , randomSecondsTillFuture()

  root.wantValueOrRejectionReasonInFuture = (succeededHereIsValue, rejectedHereIsReason) ->
    setTimeout ->
      if Wanted.didHappen
        succeededHereIsValue("hello")
      else
        rejectedHereIsReason(new Error("Bummer dude"))
    , randomSecondsTillFuture()

# look mah, no export!
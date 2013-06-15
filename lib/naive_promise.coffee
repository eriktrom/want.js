root = global ? window

root.Wanted = {}

root.randomSecondsTillFuture = (setValue) ->
  return setValue if setValue
  Math.floor(Math.random() * 1000)

root.wantValueInFuture = (succeededHereIsValue) ->
  setTimeout ->
    console.log("watch as this get logged after the test run")
    succeededHereIsValue("hello")
  , 1000

root.wantValueOrRejectionReasonInFuture = (succeededHereIsValue, rejectedHereIsReason) ->
  setTimeout ->
    if Wanted.didHappen
      succeededHereIsValue("hello")
    else
      rejectedHereIsReason(new Error("Bummer dude"))
  , randomSecondsTillFuture()

# look mah, no export!
root = global ? window

root.Wanted = {}

root.randomSecondsTillFuture = (setValue) ->
  return setValue if setValue
  Math.floor(Math.random() * 1000)

root.wantValueInFuture = (succeededHereIsValue) ->
  expectedMs = randomSecondsTillFuture()
  timeBefore = Date.now()
  setTimeout ->
    timeAfter = Date.now()
    console.log """its been more than #{timeAfter - timeBefore}
                ms since I was put on the event queue. The timer was set
                for #{expectedMs}"""
    succeededHereIsValue("hello")
  , expectedMs

root.wantValueOrRejectionReasonInFuture = (succeededHereIsValue, rejectedHereIsReason) ->
  setTimeout ->
    if Wanted.didHappen
      succeededHereIsValue("hello")
    else
      rejectedHereIsReason(new Error("Bummer dude"))
  , randomSecondsTillFuture()

# look mah, no export!
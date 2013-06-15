wantPromise = ->
  callback = null
  expectedMs = randomSecondsTillFuture()
  timeBefore = Date.now()
  setTimeout ->
    timeAfter = Date.now()
    console.log """its been more than #{timeAfter - timeBefore}
                ms since I was put on the event queue. The timer was set
                for #{expectedMs} - here is value of callback - #{callback}"""
    callback("hello") if callback # object is not a function b/c its null
  , expectedMs
  then: (_callback) ->
    callback = _callback

export = wantPromise
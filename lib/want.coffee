# wantPromise = ->
#   callback = null
#   expectedMs = randomSecondsTillFuture()
#   timeBefore = Date.now()
#   setTimeout ->
#     callback("hello")# if callback# object is not a function b/c its null
#     timeAfter = Date.now()
#     console.log """its been more than #{timeAfter - timeBefore}
#                 ms since I was put on the event queue. The timer was set
#                 for #{expectedMs} - here is value of callback - #{callback}"""
#   , expectedMs
#   then: (_callback) ->
#     callback = _callback


wantPromise = ->
  pendingCallbacks = []
  value = null
  setTimeout ->
    value = "hello"
    for callback in pendingCallbacks
      callback(value)
      console.log "Callback is #{callback}"
    pendingCallbacks = null
  , randomSecondsTillFuture()
  then: (callback) ->
    if pendingCallbacks
      pendingCallbacks.push(callback)
    else
      callback(value)

export = wantPromise
defer = ->
  pendingCallbacks = []
  value = undefined
  resolve: (_value) ->
    if pendingCallbacks
      value = _value
      for callback in pendingCallbacks
        callback(value)
      pendingCallbacks = undefined
  then: (callback) ->
    if pendingCallbacks
      pendingCallbacks.push(callback)
    else
      callback(value)

isPromise = (value) ->
  value && typeof value.then is "function"

export { defer, isPromise }
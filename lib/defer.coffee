defer = ->
  pendingCallbacks = []
  value = undefined
  resolve: (_value) ->
    if pendingCallbacks
      value = _value
      for callback in pendingCallbacks
        callback(value)
      pendingCallbacks = undefined
  promise:
    then: (callback) ->
      if pendingCallbacks
        pendingCallbacks.push(callback)
      else
        callback(value)

isPromise = (value) ->
  value && typeof value.then is "function"

ref = (value) ->
  return value if value && typeof value.then is "function"
  then: (callback) ->
    ref(callback(value))


export { defer, isPromise, ref }
defer = ->
  pendingCallbacks = []
  value = undefined
  resolve: (_value) ->
    if pendingCallbacks
      value = ref(_value) # values wrapped in a promise
      for callback in pendingCallbacks
        value.then(callback) # then called instead of callback(value)
      pendingCallbacks = undefined
  promise:
    then: (_callback) ->
      result = defer()
      # callback is wrapped so its return value is captured and used to resolve
      # the promise that then returns
      callback = (value) ->
        result.resolve(_callback(value))
      if pendingCallbacks
        pendingCallbacks.push(callback)
      else
        value.then(callback)
      result.promise

isPromise = (value) ->
  value && typeof value.then is "function"

ref = (value) ->
  return value if value && typeof value.then is "function"
  then: (callback) ->
    ref(callback(value))


export { defer, isPromise, ref }
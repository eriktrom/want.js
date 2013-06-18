defer = ->
  pendingCallbacks = []
  value = undefined
  resolve: (_value) ->
    if pendingCallbacks
      value = ref(_value)
      value.then(callback) for callback in pendingCallbacks
      pendingCallbacks = undefined
  promise:
    then: (_callback) ->
      deferred = defer()
      callback = (value) -> deferred.resolve(_callback(value))
      if pendingCallbacks then pendingCallbacks.push(callback)
      else value.then(callback)
      deferred.promise

isPromise = (value) ->
  value && typeof value.then is "function"

ref = (value) ->
  return value if isPromise(value)
  then: (callback) -> ref(callback(value))


export { defer, isPromise, ref }

# defer = ->
#   pendingCallbacks = []
#   value = undefined
#   resolve: (_value) ->
#     if pendingCallbacks
#       value = ref(_value) # values wrapped in a promise
#       for callback in pendingCallbacks
#         value.then.apply(value, callback) # apply the pending arguments to 'then'
#       pendingCallbacks = undefined
#   promise:
#     then: (_callback, _errback) ->
#       result = defer()
#       # TODO: test these default callbacks and errbacks
#       _callback = _callback || (value) ->
#         value
#       _errback = _errback || (reason) ->
#         reject(reason)
#       callback = (value) ->
#         result.resolve(_callback(value))
#       errback = (reason) ->
#         result.resolve(_errback(reason))
#       if pendingCallbacks
#         pendingCallbacks.push([callback, errback])
#       else
#         value.then(callback, errback)
#       result.promise

# reject = (reason) ->
#   then: (callback, errback) ->
#     ref(errback(reason))
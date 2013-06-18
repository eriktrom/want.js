defer = ->
  pendingThenbacks = [] # array of arrays, a thenback is [callback, errback] array
  value = undefined
  resolve: (_value) ->
    if pendingThenbacks
      value = ref(_value)
      for thenback in pendingThenbacks
        enqueue -> value.then.apply(value, thenback)
      pendingThenbacks = undefined
  promise:
    then: (_callback, _errback) ->
      deferred = defer()
      _callback = _callback || (value) -> value
      _errback = _errback || (reason) -> reject(reason)
      callback = (value) -> deferred.resolve(_callback(value))
      errback = (reason) -> deferred.resolve(_errback(reason))
      if pendingThenbacks then pendingThenbacks.push([callback, errback])
      else enqueue -> value.then([callback, errback])
      deferred.promise

isPromise = (value) ->
  value && value.then

ref = (value) ->
  return value if isPromise(value)
  then: (callback) ->
    deferred = defer()
    enqueue -> deferred.resolve(callback(value))
    deferred.promise

reject = (reason) ->
  then: (callback, errback) ->
    deferred = defer()
    enqueue -> deferred.resolve(errback(reason))
    deferred.promise

enqueue = (callback) -> setTimeout(callback, 4)

export { defer, isPromise, ref, reject, enqueue }

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
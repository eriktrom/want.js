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

isPromise = (value) -> value && value.then

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

When = (value, _callback, _errback) ->
  deferred = defer()
  done = undefined

  _callback = _callback || (value) -> value
  _errback  = _errback  || (reason) -> reject(reason)

  callback = (value) ->
    try _callback(value)
    catch reason then reject(reason)

  errback = (reason) ->
    try _errback(reason)
    catch reason then reject(reason)

  enqueue ->
    ref(value).then (value) ->
      return if done
      done = true
      deferred.resolve(ref(value).then(callback, errback))
    , (reason) ->
      return if done
      done = true
      deferred.resolve(errback(reason))

  deferred.promise

export { defer, isPromise, ref, reject, enqueue, When }
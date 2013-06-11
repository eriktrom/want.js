Want = ->

Want:: =

  oneOneSecondLater: (callback) ->
    setTimeout ->
      callback(1)
    , 1000

export = new Want;
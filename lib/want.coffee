wantPromise = ->
  setTimeout ->
    console.log("hello world")
  , randomSecondsTillFuture()
  then: ->

export = wantPromise
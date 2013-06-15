wantPromise = ->
  setTimeout ->
    console.log("hello world")
  , 1000
  then: ->

export = wantPromise
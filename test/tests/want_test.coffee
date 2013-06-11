describe "a function that can't return a value immediately", ->
  it "should forward the eventual value to a callback as an argument instead of returning the value right away", ->
    oneOneSecondLater = (callback) ->
      setTimeout ->
        callback(1)
      , 1000

    promise = oneOneSecondLater (returnValue) -> returnValue

    expect(promise).to.eq 1
    expect(promise).not.to.eq 2

import 'wantjs/want' as wantPromise

module "wantPromise"

test "is a function", ->
  expect 1
  ok typeof wantPromise is 'function'

asyncTest "returns an object with a then method", ->
  expect 1
  wp = wantPromise()

  setTimeout ->
    start()
  , 1001

  # TODO: implicitly tests that we have a then method on an object, duh
  wp.then (value) ->
    ok typeof wp is 'object'

asyncTest """observe a promise using the 'then' method.
            When the promise is fulfilled, 'callback' gets called""", ->
  callback = (value) ->
    equal value, "hello"
    start()

  wantPromise().then(callback)
  expect 1
#   ###
#     NOTE: There was a big issue with these tests last night. I even took a video
#     The problem was indeterminate tests. I think the issue was that b/c of the
#     random timer(a good thing) or even without the random timer, the first set of
#     non asyncTests, specifically 'returns an object' and 'has then method' were
#     running their code, which means, although they worked before I configured
#      the then method to take a callback, all was well, they never failed, and I
#      messed around with modules and then the Math library for quite some time, so
#      I was very, very certain that if they didn't fail for those few hours, why
#      were they all of a sudden failing when when I added the code for this test?
#      Well, for one its an async test, but even more, the non async tests were running
#      async code, and thus, sometimes, when i was lucky, it seems I was able to
#      register a callback before the timers on those tests expired, and thus, it was
#      defined when they called them. Other times I the error 'object is not a function'
#      and some other funky stuff, like the tests failed way after the runner had
#      said they'd already passed. Review the video named 'indeterminate-promise-tests'

#      To fix the issue, I currently just put an 'if callback' after the callback
#      but that won't do for the long haul. Perhaps I should try to make the non
#      async tests async instead.
#     ###
import { config } from 'want/config';

module("Basic Promise");

/*
Instead of returning values or throwing exceptions, functions return an object
that represents the eventual result of the function, either success or fail.

This object is a promise to eventually resolve.

The `then` method exposed on the promise object allows us to register a callback
that gets called during the resolution event. Thus we OBSERVE the outcome
of the resolution event, and are notified of it's outcome, which is provided
through the `value` arg of the callback function we register.
 */

asyncTest("Eventually return a value equal to 1", function() {
  expect(1);

  function eventuallyReturnOne () {
    var callback;
    function resolutionEvent (value) { callback(value); }
    config.async(resolutionEvent, 1);
    return {
      then: function(_callback) {
        callback = _callback;
      }
    };
  }

  eventuallyReturnOne().then(function(value) {
    start();
    equal(value, 1);
  });

});


module("Promise is a two state object");

/*
The "Basic Promise" had a number of problems.

1. We can only register one callback
2. If the callback is registered more than 4 milliseconds after the promise
   was constructed, it won't be called

A better solution would accept any number of callbacks that can be registered
either before or after the timeout.

To do this, we make the promise a two state object.

A promise is initially unresolved and all callbacks are added to an array of
pending observers

When the promise is resolved, all observers are notified(all callbacks are called).

After the promise has been resolved, new callbacks are called immediately.

The state `resolved` vs not is distinguished by whether the array of pending
callbacks(observers) still exists.
 */

asyncTest("Eventually return a value equal to 1", function() {
  expect(1);

  function eventuallyReturnOne () {
    var pendingCallbacks = [],
        value;

    function resolutionEvent () {
      value = 1;
      for (var i = 0; i < pendingCallbacks.length; i++) {
        var callback = pendingCallbacks[i];
        callback(value);
      }
      pendingCallbacks = undefined;
    }

    config.async(resolutionEvent, null);

    return {
      then: function(callback) {
        if (pendingCallbacks) {
          pendingCallbacks.push(callback);
        } else {
          callback(value);
        }
      }
    };
  }

  eventuallyReturnOne().then(function(value) {
    start();
    equal(value, 1);
  });

});


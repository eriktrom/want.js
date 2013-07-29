import { config } from 'want/config';

module("Basic Promise");

asyncTest("Eventually return a value equal to 1", function() {
  expect(1);

  function eventuallyReturnOne () {
    var callback;
    setTimeout(function() {
      callback(1);
    }, 4);

    // config.async(callback, 1);
    // ^^ does not work here, TypeError, callback is undefined

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

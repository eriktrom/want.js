import { config } from 'want/config';

module("Some example tests");

asyncTest("Eventually return a value equal to 1", function() {
  expect(1);

  function eventuallyReturnOne (callback) {
    config.async(callback, 1);
  }

  eventuallyReturnOne(function(value) {
    start();
    equal(value, 1, "Value equals 1");
  });

});

asyncTest("Eventually throw an exception", function() {
  expect(1);

  function eventuallyThrowException (callback, errback) {
    var pleaseError = true;
    if (!pleaseError) {
      config.async(callback, 1);
    } else {
      config.async(errback, new Error("Shit hit the fan"));
    }
  }

  eventuallyThrowException(

    function(value) {
      // never get here
    },

    function(reason) {
      start();
      throws(
        function() {
          throw reason;
        },
        /Shit hit the fan/,
        "Yes, shit hit that fan"
      );
    }
  );
});

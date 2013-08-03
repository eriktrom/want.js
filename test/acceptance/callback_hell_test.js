import { config } from 'want/config';

module("Callback Hell");

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
        function() { throw reason; },
        /Shit hit the fan/,
        "Yes, shit hit that fan"
      );
    }
  );
});

asyncTest("Callback Hell version of a callback waiting for it's arguments to hold values " +
     "derived from the result of other functions", function() {
  expect(1);

  function oneOneTickLater (callback) {
    config.async(callback, 1);
  }

  function twoOneTickLater (callback) {
    config.async(callback, 2);
  }

  function eventuallyThreeTwoTicksLater (callback) {
    var eventuallyOne,
        eventuallyTwo;

    function callbackIfAllArgsDefined () {
      if (eventuallyOne === undefined || eventuallyTwo === undefined) return;
      callback(eventuallyOne + eventuallyTwo);
    }

    oneOneTickLater(function (_eventuallyOne) {
      eventuallyOne = _eventuallyOne;
      callbackIfAllArgsDefined();
    });

    twoOneTickLater(function (_eventuallyTwo) {
      eventuallyTwo = _eventuallyTwo;
      callbackIfAllArgsDefined();
    });
  }

  eventuallyThreeTwoTicksLater(function (eventuallyThree) {
    start();
    equal(eventuallyThree, 3, "should eventually equal 3");
  });
});
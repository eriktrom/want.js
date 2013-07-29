import { config } from 'want/config';

module("Some example tests");

asyncTest("Eventually return the value of 1", function() {
  expect(1);

  function eventuallyReturnOne (callback) {
    config.async(callback, 1);
  }

  eventuallyReturnOne(function(value) {
    start();
    equal(value, 1, "Value equals 1");
  });

});
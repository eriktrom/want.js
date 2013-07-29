// import { config } from 'want/config';

module("Some example tests");

asyncTest("Eventually return the value of 1", function() {
  expect(1);

  function eventuallyReturnOne (callback) {
    setTimeout(function() {
      callback(1);
    }, 4);
  }

  eventuallyReturnOne(function(value) {
    start();
    equal(value, 1);
  });

});
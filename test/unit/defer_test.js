import { defer } from 'want/defer';


module("defer");

test("Returns an object with a 'resolve' method", function() {
  expect(1);
  ok(typeof defer().resolve === "function");
});

test("Returns an object with a 'then' method", function() {
  expect(1);
  ok(typeof defer().then === "function");
});

asyncTest("Registers an observer(callback) that is notified(called) and returns " +
          "a value equal to 1 in the next turn", function() {
  expect(1);

  function eventuallyReturnOne () {
    var deferred = defer();
    deferred.resolve(1);
    return deferred;
  }

  eventuallyReturnOne().then(function(value) {
    start();
    equal(value, 1);
  });
});

asyncTest("Only the first call to resolve can set the resolution", function() {
  expect(1);

  function eventuallyReturnOne () {
    var deferred = defer();
    deferred.resolve(1);
    deferred.resolve(2);
    return deferred;
  }

  eventuallyReturnOne().then(function(value) {
    start();
    equal(value, 1);
  });
});

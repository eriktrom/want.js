import { defer } from 'want/defer';


module("defer");

test("resolve - is a function that provides the capability to determine the resolution", function() {
  expect(1);
  ok(typeof defer().resolve === "function");
});

test("promise & promise.then - promise is an object that gives the authority to " +
     "observe the resolution and act accordingly via its 'then' method", function() {
  expect(2);

  var promise = defer().promise;

  ok(typeof promise === "object");
  ok(typeof promise.then === "function");
});

asyncTest("Registers an observer(callback) that is notified(called) and returns " +
          "a value equal to 1 in the next turn", function() {
  expect(1);

  function eventuallyReturnOne () {
    var deferred = defer();
    deferred.resolve(1);
    return deferred.promise;
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
    return deferred.promise;
  }

  eventuallyReturnOne().then(function(value) {
    start();
    equal(value, 1);
  });
});

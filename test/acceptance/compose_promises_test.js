import { defer } from 'want/defer';

module("Compose Promises");

/*
For this to work, several things need to happen:
- the `then` method must return a promise
- the returned promise must be eventually resolved with the return value of the
  callback
- the return value of the callback must either be a fulfilled value or a promise
*/

// asyncTest("An eventual value of 1 + eventual value of 2 should eventually = 3", function() {
//   expect(1);

//   function eventuallyOne () {
//     var deferred = defer();
//     deferred.resolve(1);
//     return deferred.promise;
//   }

//   function eventuallyTwo () {
//     var deferred = defer();
//     deferred.resolve(2);
//     return deferred.promise;
//   }

//   eventuallyOne().then(function(oneValue) {
//     return eventuallyTwo(function(twoValue) {
//       start();
//       equal(oneValue + twoValue, 3, "eventually equals 3");
//     });
//   });

// });
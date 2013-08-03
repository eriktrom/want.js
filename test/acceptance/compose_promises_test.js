import { defer } from 'want/defer';

module("Compose Promises");

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
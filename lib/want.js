export function Counter () {
  this.count = 0;
}

Counter.prototype = {

  incr: function () {
    this.count++;
  },

  decr: function() {
    this.count--;
  }

};
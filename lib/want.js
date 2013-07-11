function StatusHolder () {
  if (!(this instanceof StatusHolder)) {
    return new StatusHolder();
  }

  this.currentStatus = 'all good';

}

StatusHolder.prototype = {
  // constructor: StatusHolder,
  getStatus: function() {
    return this.currentStatus;
  }
};

export { StatusHolder };
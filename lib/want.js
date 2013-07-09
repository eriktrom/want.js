function StatusHolder () {
  if (!(this instanceof StatusHolder)) {
    return new StatusHolder();
  }

}

StatusHolder.prototype = {
  constructor: StatusHolder,
  getStatus: function() {
    return 'all good';
  }
};

export { StatusHolder };
import { config } from 'want/config';

export function defer () {
  var pendingCallbacks = [],
      value;

  return {
    resolve: function(_value) {
      if (pendingCallbacks) {
        value = _value;
        for (var i = 0; i < pendingCallbacks.length; i++) {
          var callback = pendingCallbacks[i];
          config.async(callback, value);
        }
        pendingCallbacks = undefined;
      }
    },

    promise: {
      then: function(callback) {
        if (pendingCallbacks) {
          pendingCallbacks.push(callback);
        } else {
          callback(value);
        }
      }
    }


  };
}
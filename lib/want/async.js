var async;

function useSetTimeout () {
  return function(callback, arg) {
    setTimeout(function() {
      callback(arg);
    }, 4);
  };
}

async = useSetTimeout();

export { async };
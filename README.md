Usage
=====
1. run `npm install --save-dev`
2. run `grunt server`
3. open [http://localhost:8000/test](http://localhost:8000/test), or don't cause it'll also output to your cli with karma.

*Optionally*, feel free to point as many devices as you want from your local network to:  

a. `http://your-local-ip:8000/test` (<-- not a link cause you need to add your own local ip)
  - this will use livereload to run the mocha test runner on the device itself  
b. `http://your-local-ip:9876`
  - this will connect your device to your computer and listen for when you save files, running the tests with karma, output to the cli and growl notification.








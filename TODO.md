- fix jshint
- wrap window.requireModule inside closure, not outside
- remove the need for define, requireModule using es6 module transpiler?
- make any hardcoded references to the name of the pkg.name use <%= pkg.name %>
- make it so that adding a dependency (like in vendor) does not require adding it to both qunit index.html and karma files
- make a new project based on this pipeline into a generator
- use grunt-microlib (takes care of wrapping globals inside anonymous function)
- consider using growl npm package for noise when not using karma(or instead of karma)
- make sure this setup is the same as ember-app-kit (minus the ember stuff)
- update to the correct version of loader.js
- consider ways to not rebuild whole project on change, but only changed files
- add coffee script source maps (for tests, although not a priority for regular js libs)
- consider what I am missing in comparison to ember-dev
- add minification grunt task

- compare with the setup used in glazier
- compare to the setup used by thomasboyt

- make a mocha version that is just as resiliant
- find a way to make a base version where mocha or qunit can be used

- things like QUnit.config.requireExpects = true should be explicitly defined on a global object that's aliased from window(in browser)

- is the project directory structure correct(according to the new conventions of app-kit)

- make it so adding cucumber js is dead easy (generator)

- adding dependencies to vendor should not require updating the test runner file(already mentioned, but worth mentioning again)

- make it so this lib can be used in node or the browser, conside the use of `dist/commonjs/main.js`

- build final files out to the 'dist' directory
- use the globals option for es6 module transpiler (look at conductor.js for help)
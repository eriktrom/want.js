Example: 
=========
a 'statusHolder' object implementing the listener pattern

Step 1: Create the sequential example, without promises and expose
the problems associated with it. This requires turning the java
examples into javascript

Sequential Listener Pattern:
============================

- statusHolder
- publishers
- subscribers

- statusHolder object is used to coordinate a changing status between publishers
and subscribers

- subscriber can ask for current status of statusHolder by calling `getStatus`
- subscriber can subscribe to receive notifications when the status changes by
calling `addListener` with a listener object

- publisher changes the status in a statusHolder by calling setStatus, with a 
new value. This in turn will call statusChanged on all subscribed listeners

The point here is so that publishers can communicate status updates to
subscribers without knowing of each individual subscriber.
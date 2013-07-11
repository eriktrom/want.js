import { StatusHolder } from 'want'

# class StatusHolder
#   currentStatus = 'all good'
#   currentStatusProp: 'all good'
#   currentStatusPropFunc: -> 'all good'
#   @currentStatusIvar = 'all good'
#   constructor: ->
#     @currentStatusInConstructor = 'all good'


module "Implementing the Listener Pattern"

test "subscriber can ask for the current status of a status holder", ->
  expect 1
  statusHolder = new StatusHolder()
  strictEqual statusHolder.getStatus(), 'all good'


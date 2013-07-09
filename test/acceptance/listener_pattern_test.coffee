import { StatusHolder } from 'want'

module "Implementing the Listener Pattern"

test "subscriber can ask for the current status of a status holder", ->
  expect 1
  statusHolder = new StatusHolder
  strictEqual statusHolder.getStatus(), 'all good'


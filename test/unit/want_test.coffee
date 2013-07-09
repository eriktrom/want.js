import { StatusHolder } from 'want'
module "StatusHolder"

test "it is a function", ->
  expect 2
  ok typeof StatusHolder is 'function'
  ok new StatusHolder instanceof StatusHolder

test "it can be initialized without using 'new' keyword", ->
  expect 1
  ok StatusHolder() instanceof StatusHolder
import Counter from "want/main"

module "Counter"
test "it is a function", ->
  expect 1
  ok typeof Counter is "function"
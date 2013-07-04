import hello from "wantjs/want"

module "Qunit Works"
test "let me prove it to you", ->
  expect 1
  ok true, "should be true"

test "hello", ->
  expect 1
  equal hello(), "it works"
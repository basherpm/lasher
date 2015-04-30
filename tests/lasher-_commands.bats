#!/usr/bin/env bats

load test_helper

@test "without arguments prints usage" {
  run lasher-_commands
  assert_failure
  assert_line "Usage: lasher _commands <prefix>"
}

@test "lists commands" {
  run lasher-_commands lasher
  assert_success
  assert_line help
  assert_line new-command
}

@test "does not list hidden commands" {
  run lasher-_commands lasher
  assert_success
  refute_line _commands
}

#!/usr/bin/env bats

load test_helper

@test "without args, show help for root lasher command" {
  run lasher-help

  assert_success

  assert_line "Usage: lasher <command> [<args>]"
}

@test "shows help for a specific command" {
  cat > "${LASHER_TMP_BIN}/lasher-hello" <<SH
#!shebang
# Usage: lasher hello <world>
# Summary: Says "hello" to you
# This command is useful for saying hello.
echo hello
SH

  run lasher-help hello

  assert_success
  assert_output <<SH
Usage: lasher hello <world>

This command is useful for saying hello.
SH
}

#!/usr/bin/env bats

load test_helper

@test "creates a new command with exec permission on current directory" {
  run lasher-new-command prefix-echo

  assert_success

  assert [ "$(cat libexec/prefix-echo)" = "#!/usr/bin/env bash" ]
  [[ "$(ls -l libexec/prefix-echo | cut -f 1 -d ' ')" == "-rwx"* ]]
}

@test "doesn't touch existing commands" {
  mkdir libexec
  echo "echo" > "libexec/prefix-echo"

  run lasher-new-command prefix-echo
  assert_failure
  assert [ "$(cat libexec/prefix-echo)" = "echo" ]
}

@test "creates a test for the command" {
  template="#!/usr/bin/env bats

load test_helper"

  run lasher-new-command prefix-echo
  assert_success
  assert [ "$(cat tests/prefix-echo.bats)" = "$template" ]
}

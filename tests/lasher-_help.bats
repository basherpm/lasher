#!/usr/bin/env bats

load test_helper

@test "without args shows usage" {
  run lasher-_help

  assert_failure
  assert_line "Usage: lasher _help [--usage] [<prefix>] <command>"
}

@test "invalid command" {
  run lasher-_help command invalid_subcommand

  assert_failure "command: no such command 'invalid_subcommand'"
}

@test "shows help for a specific command" {
  cat > "${LASHER_TMP_BIN}/command-hello" <<SH
#!shebang
# Usage: command hello <world>
# Summary: Says "hello" to you
# This command is useful for saying hello.
echo hello
SH

  run lasher-_help command hello

  assert_success
  assert_output <<SH
Usage: command hello <world>

This command is useful for saying hello.
SH
}

@test "replaces missing extended help with summary text" {
  cat > "${LASHER_TMP_BIN}/command-hello" <<SH
#!shebang
# Usage: command hello <world>
# Summary: Says "hello" to you
echo hello
SH

  run lasher-_help command hello

  assert_success
  assert_output <<SH
Usage: command hello <world>

Says "hello" to you
SH
}

@test "extracts only usage" {
  cat > "${LASHER_TMP_BIN}/command-hello" <<SH
#!shebang
# Usage: command hello <world>
# Summary: Says "hello" to you
# This extended help won't be shown.
echo hello
SH

  run lasher-_help --usage command hello

  assert_success "Usage: command hello <world>"
}

@test "multiline usage section" {
  cat > "${LASHER_TMP_BIN}/command-hello" <<SH
#!shebang
# Usage: command hello <world>
#        command hi [everybody]
#        command hola --translate
# Summary: Says "hello" to you
# Help text.
echo hello
SH

  run lasher-_help command hello

  assert_success
  assert_output <<SH
Usage: command hello <world>
       command hi [everybody]
       command hola --translate

Help text.
SH
}

@test "multiline extended help section" {
  cat > "${LASHER_TMP_BIN}/command-hello" <<SH
#!shebang
# Usage: command hello <world>
# Summary: Says "hello" to you
# This is extended help text.
# It can contain multiple lines.
#
# And paragraphs.

echo hello
SH

  run lasher-_help command hello

  assert_success
  assert_output <<SH
Usage: command hello <world>

This is extended help text.
It can contain multiple lines.

And paragraphs.
SH
}

#!/usr/bin/env bats

load test_helper

@test "configure with no arguments" {
  run configure
  assert_failure
  assert_output "
Configures a thing

Usage:
  To configure a thing

 To see these usage instructions:
 ./libexec/configure help"
}

@test "configure help" {
  run configure help
  assert_success
  assert_output "
Configures a thing

Usage:
  To configure a thing

 To see these usage instructions:
 ./libexec/configure help"
}

@test "configure thing" {
  run configure thing
  assert_success
  assert_output "Option: 'thing'"
}

@test "configure a bunch of things" {
  run configure a bunch of things
  assert_success
  assert_output "Option: 'a'
Option: 'bunch'
Option: 'of'
Option: 'things'"
}

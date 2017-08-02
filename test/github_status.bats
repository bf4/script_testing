#!/usr/bin/env bats

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

setup() {
  source "${BATS_TEST_DIRNAME}/../libexec/github_status"
  # prevent  bats/libexec/bats-exec-test: line 248: BATS_TEST_SKIPPED: unbound variable
  set +o nounset
}

teardown() {
  cleanup
}

@test 'github_status        parses -owner me' {
  refute "$owner"

  parse_args -owner me

  assert_equal "$owner" me
}

@test 'github_status        parses -repo my_repo' {
  refute "$repo"

  parse_args -repo my_repo

  assert_equal "$repo" my_repo
}

@test 'github_status        parses -context coverage' {
  refute "$context"

  parse_args -context coverage

  assert_equal "$context" coverage
}

@test 'github_status        parses -description "Awesome Job"' {
  refute "$description"

  parse_args -description "Fantastic Job"

  assert_equal "$description" "Fantastic Job"
}

@test 'github_status        parses -desc "Great Job"' {
  refute "$description"

  parse_args -desc "Great Job"

  assert_equal "$description" "Great Job"
}

@test 'github_status        parses -state pending' {
  refute "$state"

  parse_args -state pending

  assert_equal "$state" pending
}

@test 'github_status        parses -state success' {
  refute "$state"

  parse_args -state success

  assert_equal "$state" success
}

@test 'github_status        parses -state error' {
  refute "$state"

  parse_args -state error

  assert_equal "$state" error
}

@test 'github_status        parses -state failure' {
  refute "$state"

  parse_args -state failure

  assert_equal "$state" failure
}

@test 'github_status        parses invalid -state not_a_state' {
  skip "This test doesn't handle the system exit nor captured output"

  refute "$state"

  parse_args -state not_a_state

  assert_output  --partial "Invalid State: 'not_a_state'"
  refute "$state"
}

@test 'github_status        parses -url https://circleci.com/gh/:owner/:repo/1337' {
  refute "$target_url"

  parse_args -url https://circleci.com/gh/:owner/:repo/1337

  assert_equal "$target_url" https://circleci.com/gh/:owner/:repo/1337
}


@test 'github_status        parses get 1337' {
  refute "$pr"
  refute "$cmd"

  parse_args get 1337

  assert_equal "$cmd" get
  assert_equal "$pr" 1337
}

@test 'github_status        parses create 1337' {
  refute "$pr"
  refute "$cmd"

  parse_args create 1337

  assert_equal "$cmd" create
  assert_equal "$pr" 1337
}

@test 'github_status        parses invalid command "update 1337"' {
  skip
}

@test 'github_status        parses missing command "1337"' {
  skip
  assert_output "Missing [cmd] [pr number]. got 1337"
}

@test 'github_status        parses missing pr "create"' {
  skip
  assert_output "Missing [cmd] [pr number]. got create"
}

@test 'github_status        create_status()' {
  skip "test validating options, etc"
}

@test 'github_status        create_payload()' {
  skip
}

@test 'github_status        get_status()' {
  skip
}

@test 'github_status        get_sha()' {
  skip
}

@test 'github_status        print_statuses()' {
  skip
}

@test 'github_status        show_help()' {
  skip
}

@test 'github_status        cleanup()' {
  skip
}

@test 'github_status        info()' {
  skip
}

@test 'github_status        error()' {
  skip
}

@test 'github_status        fatal()' {
  skip
}

@test 'github_status        debug(), DEBUG' {
  skip
}

@test 'github_status        run: finish()' {
  skip
}

@test 'github_status        run: finish_error()' {
  skip
}

@test 'github_status        run: no args' {
  skip
}

@test 'github_status        run: missing GITHUB_REPO_STATUS_TOKEN' {
  skip
}

@test 'github_status        run: customize GITHUB_USER_AGENT' {
  skip
}

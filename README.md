# Script Testing [![CircleCI](https://circleci.com/gh/bf4/script_testing.svg?style=svg)](https://circleci.com/gh/bf4/script_testing)

## Setup

```bash
bin/setup
```

## Test

```bash
bin/test
```

Uses https://github.com/sstephenson/bats

## GitHub Status

See http://www.benjaminfleischer.com/how-to-set-multiple-github-pull-request-statuses

Or on CircleCI, with `GITHUB_STATUS_ACCESS_TOKEN` in the env, the `circle.yml` may look like:

```yaml
test:
  override:
    - |
      if bin/test; then state="success"; desc="Tests passed"
      else              state="failure"; desc="Test failures"; fi
      context="tests"
      github_status create "$GITHUB_STATUS_PR_NUMBER" -url "$GITHUB_STATUS_TARGET_URL" -context "${context}" -state "${state}" -desc "${desc}"
      if [ "$state" = "failure" ]; then false; else true; fi # 'false' fails the build
  post:
    - |
      if bin/lint-style; then state="success"; description="Such style"
      else                    state="failure"; description="Style errors"; fi
      context="lint_style"
      github_status create "$GITHUB_STATUS_PR_NUMBER" -url "$GITHUB_STATUS_TARGET_URL" -context "${context}" -state "${state}" -desc "${desc}"
      if [ "$state" = "failure" ]; then false; else true; fi # 'false' fails the build

dependencies:
  cache_directories:
    - "~/.local/bin"
  post:
  - |
    if ! command -v github_status &>/dev/null; then
      mkdir -p "$HOME/.local/bin"
      wget https://github.com/bf4/script_testing/raw/master/libexec/github_status && chmod +x github_status
      mv github_status "$HOME/.local/bin"
      github_status help
    fi

machine:
  environment:
    PATH: $HOME/.local/bin:$PATH
    GITHUB_STATUS_USER_AGENT: "bf4ExampleCiStatus"
    GITHUB_STATUS_PR_NUMBER: "${CIRCLE_PR_NUMBER:-$CIRCLE_SHA1}"
    GITHUB_STATUS_REPO_OWNER: "$CIRCLE_PROJECT_USERNAME"
    GITHUB_STATUS_REPO_NAME: "${CIRCLE_PR_REPONAME:-$CIRCLE_PROJECT_REPONAME}"
    GITHUB_STATUS_TARGET_URL: "$CIRCLE_BUILD_URL"
```

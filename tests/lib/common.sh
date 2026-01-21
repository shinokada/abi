#!/usr/bin/env bash

# Shared helper functions for test scripts

# Portable timeout runner for macOS and Linux compatibility
run_with_timeout() {
  local duration="$1"
  shift
  local seconds="${duration%s}" # strip trailing 's' if present
  if command -v timeout &>/dev/null; then
    timeout "${duration}" "$@"
  elif command -v gtimeout &>/dev/null; then
    gtimeout "${duration}" "$@"
  else
    "$@" &
    local pid=$!
    (
      sleep "${seconds}"
      kill -0 "${pid}" 2>/dev/null && kill "${pid}"
    ) &
    local killer=$!
    wait "${pid}"
    local status=$?
    kill "${killer}" 2>/dev/null || true
    return "${status}"
  fi
}

export -f run_with_timeout

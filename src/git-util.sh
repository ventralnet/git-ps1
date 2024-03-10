#!/bin/bash

__current_branch() {
  echo $(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git --no-optional-locks rev-parse --short HEAD 2>/dev/null);
}

__has_staged() {
  if git status --porcelain | grep -qE "^[[:space:]](A|M|D)"; then
    echo "true"
  else
    echo ""
  fi
}

__has_untracked() {
  if git status --porcelain 2> /dev/null | grep -qE "^\?\?"; then
    echo "true"
  else
    echo ""
  fi
}

__is_dirty() {
  # Check for unstaged changes with --shortstat option
  if git diff --shortstat 2> /dev/null | grep -qE "[[:digit:]]+ file[s]* changed"; then
    echo "true"
  # Check for untracked files with --porcelain option
  elif git status --porcelain 2> /dev/null | grep -qE "^\?\?"; then
    echo "true"
  # Check for new files with --cached option (implicitly staged)
  elif git diff --cached --name-only 2> /dev/null | grep -qE "."; then
    echo "true"
  else
    echo ""
  fi
}

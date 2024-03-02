#!/bin/bash

__current_branch() {
  echo $(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git --no-optional-locks rev-parse --short HEAD 2>/dev/null);
}

__is_branch_dirty() {
  if [[ $(git --no-optional-locks ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1;) != '' ]]; then
    echo 'true'
  else
    echo ''
  fi
}


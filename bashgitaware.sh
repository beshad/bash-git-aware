#!/bin/bash

LAST_GIT_PATH=""
git_branch=""
git_dirty=""

# Find the current git branch
find_git_branch() {
  local branch
  local CURRENT_PATH

  CURRENT_PATH=$(pwd)

  branch=$(git symbolic-ref --short HEAD 2>/dev/null)

  # Check if we're in a git repository
  if [[ -n "$branch" ]]; then
    # Update remote branches in the background if the directory changed
    if [[ "$CURRENT_PATH" != "$LAST_GIT_PATH" ]]; then
      git remote update >/dev/null 2>&1 &
    fi
    LAST_GIT_PATH="$CURRENT_PATH"

    # Handle detached HEAD state
    if [[ "$branch" == "HEAD" ]]; then
      branch='🆘DETACHED'
    fi

    # Set the git_branch variable
    git_branch=" 🌴$branch "
  else
    git_branch=""
  fi
}

# Find if the git repository is dirty
find_git_dirty() {
  local status
  status=$(git status 2>/dev/null)

  # Reset git_dirty for each call
  git_dirty=""

  # Check if we're in a git repository
  if [[ "$status" =~ "Not a git repository" ]]; then
    return
  fi

  # Use pattern matching to check for different git states
  if [[ "$status" =~ "Untracked files" ]]; then
    git_dirty+="⭐ "
  fi
  if [[ "$status" =~ "Changes not staged for commit" ]]; then
    git_dirty+="⭐ "
  fi
  if [[ "$status" =~ "Your branch is ahead of" ]]; then
    git_dirty+="⤴️"
  fi
  if [[ "$status" =~ "Your branch is behind" ]]; then
    git_dirty+="⤵️ "
  fi
  if [[ "$status" =~ "Changes to be committed" ]]; then
    git_dirty+="💾 "
  fi
  if [[ "$status" =~ "have diverged" ]]; then
    git_dirty+="🔀 "
  fi
  if [[ "$status" =~ "Your branch is up to date with" ]]; then
    if [[ -z "$git_dirty" ]]; then
      git_dirty+="✅ "
    fi
  fi
}

# Set the PROMPT_COMMAND to call the functions before each prompt
PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"

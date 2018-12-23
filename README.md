# Bash Git Aware (OSX)

Adds symbols showing git status:

- ✅  No local or remote changes
- ✴️  Unstaged changes
- ➡️  Uncommitted changes
- ⬆️  Local changes ready to be pushed
- ⬇️  New remote changes

## Setup

    mkdir -p "$HOME/.bash-git-aware"
    git clone https://github.com/beshad/bash-git-aware "$HOME/.bash-git-aware/bash-git-aware"


Then in your `~/.bash_profile` add these lines:

    export BASHGITAWARE=~/.bash-git-aware/bash-git-aware
    source "${BASHGITAWARE}/index.sh"

Update `PS1` to look something like below. Must include the vars `$git_branch` and `$git_dirty`

PS1="\n\[\033[35m\]\$(/bin/date)\n\[\033[32m\]\w \[\033[00m\]\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\n\[\033[1;32m\]\u\[\033[1;33m\]@\h\[$txtrst\] $ "
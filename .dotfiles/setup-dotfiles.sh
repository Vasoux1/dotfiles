#!/usr/bin/env bash

# Define the dotfiles repo and destination
DOTFILES_DIR="$HOME/.dotfiles"

# Ensure the directory is not already present
if [ -d "$DOTFILES_DIR" ]; then
  echo "Error: $DOTFILES_DIR already exists. Exiting."
  exit 1
fi

# Define the alias for managing dotfiles
function dotfiles {
  /usr/bin/git --git-dir=$DOTFILES_DIR --work-tree=$HOME "$@"
}

# Check out the dotfiles into the home directory
dotfiles checkout

# If there are conflicts, back up existing dotfiles
if [ $? -ne 0 ]; then
  echo "Backing up pre-existing dotfiles."
  mkdir -p dotfiles-backup
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} dotfiles-backup/{}
fi

# Retry the checkout
dotfiles checkout

# Hide untracked files
dotfiles config --local status.showUntrackedFiles no

echo "Dotfiles are successfully set up!"


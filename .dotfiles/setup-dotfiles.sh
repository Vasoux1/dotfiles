#!/usr/bin/env sh

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/dotfiles-backup"

if [ -d "$DOTFILES_DIR" ]; then
  echo "Error: $DOTFILES_DIR already exists. Exiting."
  exit 1
fi

git clone --bare https://github.com/Vasoux1/dotfiles "$DOTFILES_DIR"

config() {
  /usr/bin/git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

config checkout

if [ $? -ne 0 ]; then
  echo "Backing up pre-existing dotfiles to $BACKUP_DIR."

  mkdir -p "$BACKUP_DIR"

  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | while read -r file; do
    mkdir -p "$BACKUP_DIR/$(dirname "$file")"
    mv "$file" "$BACKUP_DIR/$file"
  done

  config checkout
  if [ $? -ne 0 ]; then
    echo "Error: Dotfiles setup failed even after backing up existing files. Please check the logs."
    exit 1
  else
    echo "Dotfiles setup completed after backing up existing files."
  fi
else
  echo "Dotfiles are successfully set up!"
fi

config config --local status.showUntrackedFiles no

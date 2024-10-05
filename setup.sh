#!/usr/bin/env sh

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/dotfiles-backup"

clone_dotfiles() {
  if [ -d "$DOTFILES_DIR" ]; then
    echo "Error: $DOTFILES_DIR already exists. Exiting."
    exit 1
  fi

  git clone --bare https://github.com/Vasoux1/dotfiles "$DOTFILES_DIR"
}

config() {
  /usr/bin/git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

backup_existing_dotfiles() {
  echo "Backing up pre-existing dotfiles to $BACKUP_DIR."

  mkdir -p "$BACKUP_DIR"

  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | while read -r file; do
    mkdir -p "$BACKUP_DIR/$(dirname "$file")"
    mv "$file" "$BACKUP_DIR/$file"
  done
}

setup_dotfiles() {
  config config --local status.showUntrackedFiles no
  config checkout
  if [ $? -ne 0 ]; then
    backup_existing_dotfiles

    config checkout
    if [ $? -ne 0 ]; then
      echo "Error: Dotfiles setup failed even after backing up existing files." 
      exit 1
    else
      echo "Dotfiles setup completed after backing up existing files."
    fi
  else
    echo "Dotfiles successfully set up!"
  fi

  ~/dotfiles/system.sh
  . ~/.bashrc
}

# Execution
clone_dotfiles
setup_dotfiles
echo "Dotfiles setup complete."

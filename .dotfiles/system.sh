#!/usr/bin/env sh

install_apt_packages() {
  echo "Updating and installing apt packages..."
  sudo apt update && sudo apt upgrade -y

  PACKAGES="git vim curl python3 python3-pip eza gh"

  for PACKAGE in $PACKAGES; do
    if ! dpkg -l | grep -q "$PACKAGE"; then
      echo "Installing $PACKAGE..."
      sudo apt install -y "$PACKAGE"
    else
      echo "$PACKAGE is already installed."
    fi
  done
}

install_zoxide() {
  if ! command -v zoxide >/dev/null 2>&1; then
    echo "Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  else
    echo "zoxide is already installed."
  fi
}

install_vim_plug() {
  if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  else
    echo "vim-plug is already installed."
  fi
}

run_plug_install() {
  echo "Running :PlugInstall in Vim..."
  vim +'PlugInstall --sync' +qa
}

cleanup_files() {
  echo "Removing README.md and setup.sh from home directory..."
  rm -f ~/README.md ~/setup.sh
}

# Main function 
setup_system() {
  install_apt_packages
  install_zoxide
  install_vim_plug
  run_plug_install
  cleanup_files
}

setup_system
echo "System setup complete."


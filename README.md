# Dotfiles

This repository contains my personal dotfiles and a script to set them up easily on a new machine.

## Setup

To set up your environment with these dotfiles, follow these steps:

1. Clone this repository:
   ```bash
   git clone --bare https://github.com/Vasoux1/configs.git ~/.dotfiles
   ```

2. Change into the directory:
    ``` bash
    cd ~/.dotfiles
    ```

3. Run the setup script:
    ```bash
    ./setup-dotfiles.sh
    ```

## Notes

- The script will back up existing dotfiles in your home directory if there are conflicts.
- Ensure you have Git installed before running the script

# Contributing

Feel free to fork this repository and submit pull requests if you have suggestions or improvements!

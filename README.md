# Dotfiles

This repository contains my personal dotfiles and a script to set them up easily on a new machine.

## Setup

To set up your environment with these dotfiles, follow these steps:

1. Clone this repository:
   ```bash
   git clone --bare https://github.com/Vasoux1/dotfiles.git ~/.dotfiles
   ```

2. Make an alias so you can work with.
    ```
    alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    ``` 
3. Run the script
    ```
    bash <(curl -s https://gist.github.com/4e0faa69d25793126967b11ccdd7d47d.git)
    ```
    (or force with the -f flag)

## Notes

- The script will back up existing dotfiles in your home directory if there are conflicts.
- Ensure you have Git installed before running the script

# Contributing

Feel free to fork this repository and submit pull requests if you have suggestions or improvements!

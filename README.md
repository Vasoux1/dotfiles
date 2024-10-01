## Setup

A bare repo that sotres my configs

1. Clone repository:
   ```
   git clone --bare https://github.com/Vasoux1/dotfiles.git ~/.dotfiles
   ```

2. Create an elias:
    ```
    alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    ``` 
3. Checkout. If files already exist, backup or force with -f flag
    ```
    dot checkout
    ```
*   Alternatively, run the command below to set everything up:
    ```
    curl -Lks https://bit.ly/bitd0t | sh
    ```

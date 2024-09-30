# vim: set filetype=sh :
# my aliases


# eval "$(gh copilot alias -- bash)"
alias sbash='source ~/.bashrc'
alias vb='vim ~/.bashrc'
alias vp='vim ~/.bash_aliases'
alias vt='vim ~/.tmux.conf'
alias vn='vim ~/.config/nvim/init.vim'
alias cdwm='cd ~/.config/arco-dwm'
alias csl='cd ~/.config/arco-slstatus'
alias ctlsddm='sudo systemctl restart sddm.service'
alias cbright='echo "$(($(cat /sys/class/backlight/intel_backlight/brightness) / 960))"%'
alias cbattery='echo "$(cat /sys/class/power_supply/BAT1/capacity)"%' 
alias ..='cd ..'
alias ...='cd ../..'
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gits='git status'
alias gita='git add'
alias gitc='git commit -m'
alias clearswap='rm -rf ~/.cache/vim/swap/*'
alias minbright='xbacklight -set 0.1'
alias fman='ls /bin | fzf | xargs man'
alias bat='batcat'
alias cd='z'

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}


# ----- Bat (better cat) -----

export BAT_THEME=tokyonight_night

# ---- Zoxide (better cd) ----
 eval "$(zoxide init bash)"


# ~/.bashrc: executed by bash(1) for non-login shells.
# See {/usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

# --------------------------------------------------------------
# Interactive shell check (exit if non-interactive shell)
# --------------------------------------------------------------
case $- in
    *i*) ;;  # Interactive shell
      *) return;;  # Non-interactive, exit
esac

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"


# --------------------------------------------------------------
# History configuration
# --------------------------------------------------------------
HISTCONTROL=ignoreboth    # Avoid duplicate lines and lines starting with space
HISTSIZE=1000             # Number of commands to remember in history
HISTFILESIZE=2000         # Max size of history file

# --------------------------------------------------------------
# Shopt
# --------------------------------------------------------------
shopt -s checkwinsize     # Update LINES and COLUMNS after each command
shopt -s cdspell		  # Autocorrects cd misspellings
shopt -s cmdhist		  # Save multi-line commands in history as single line
shopt -s expand_aliases
shopt -s histappend       # Append to history instead of overwriting

# --------------------------------------------------------------
# Prompt configuration
# --------------------------------------------------------------
# Identify chroot and set a fancy prompt with color support
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Uncomment for a colored prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Kali config variables (Keep as-is)
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=oneline
NEWLINE_BEFORE_PROMPT=no
# STOP KALI CONFIG VARIABLES
# Parse Git branch for prompt

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Prompt settings
if [ "$color_prompt" = yes ]; then
    # Virtualenv and color settings
    VIRTUAL_ENV_DISABLE_PROMPT=1
    prompt_color='\[\033[;32m\]'
    info_color='\[\033[1;34m\]'
    prompt_symbol=㉿

    [ "$EUID" -eq 0 ] && prompt_symbol=💀 && prompt_color='\[\033[;94m\]' && info_color='\[\033[1;31m\]'

    case "$PROMPT_ALTERNATIVE" in
        twoline)
            PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)}(${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)$prompt_color)}'$info_color'\u'$prompt_symbol'\h'$prompt_color')-[\[\033[0;1m\]\w$prompt_color]\n└─'$info_color'\$\[\033[0m\] '
            ;;
        oneline)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}'$info_color'\u@\h:'$prompt_color'\[\033[01m\]\w\[\033[00m\]\$\[\033[0;33m\]$(parse_git_branch)\[\033[0m\] '
            ;;
        backtrack)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h:\[\033[01;34m\]\w\[\033[00m\]\$ '
            ;;
    esac

    unset prompt_color info_color prompt_symbol
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

[ "$NEWLINE_BEFORE_PROMPT" = yes ] && PROMPT_COMMAND="PROMPT_COMMAND=echo"

# Set xterm title to user@host:dir
case "$TERM" in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
esac

# --------------------------------------------------------------
# Shell behavior and aliases
# --------------------------------------------------------------
# History ignores case for tab completion
bind "set completion-ignore-case on"

# Bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Enable color support of ls, grep, etc.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='eza --color=auto'
    alias ll='eza -lAh --icons=always'
    alias la='eza -A --icons=always'
    alias l='eza -CF --icons=always'
    alias tree='eza --tree'
    alias grep='grep --color=auto'
    # alias fgrep='fgrep --color=auto'
    # alias egrep='egrep --color=auto'
fi

# --------------------------------------------------------------
# Additional functions and scripts
# --------------------------------------------------------------
# Extractor function for all kinds of archives
ex () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2) tar xjf $1   ;;
            *.tar.gz)  tar xzf $1   ;;
            *.bz2)     bunzip2 $1   ;;
            *.rar)     unrar x $1   ;;
            *.gz)      gunzip $1    ;;
            *.tar)     tar xf $1    ;;
            *.tbz2)    tar xjf $1   ;;
            *.tgz)     tar xzf $1   ;;
            *.zip)     unzip $1     ;;
            *.Z)       uncompress $1;;
            *.7z)      7z x $1      ;;
            *.deb)     ar x $1      ;;
            *.tar.xz)  tar xf $1    ;;
            *.tar.zst) tar xf $1    ;;
            *)         echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Load personal bash aliases if available
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load personal bash configurations if available
[[ -f ~/.bashrc-personal ]] && . ~/.bashrc-personal

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


### ALIASES ###

#switch between bash and zsh
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"


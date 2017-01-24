#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
alias xclip="xclip -selection c"
alias ss="maim -s ~/screenshot.png"

# Neovim
alias vim="nvim"
alias vi="nvim"

# Git
alias gs="git status"
alias gd="git diff"
alias gp="git push"
alias gl="git log"
alias ga="git add -A"
alias gc="git commit -m"

export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"


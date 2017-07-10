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
alias sx="maim -s ~/screenshot.png"
alias sc="scrot -c -d 5 ~/screenshot.png"

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

# Tmux
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias tls="tmux list-sessions"
alias tk="tmux kill-session -t"


export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export GEM_HOME=$(ruby -e 'print Gem.user_dir')


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

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

alias clip="xclip -selection c"
alias sx="maim -s ~/screenshot.png"
alias sc="scrot -c -d 5 ~/screenshot.png"

# Neovim
alias vim="nvim"
alias vi="nvim"

# Git
alias gs="git status"
alias gd="git diff"
alias gds="git diff --stat"
alias gdd="git diff --no-index"
alias gp="git push"
alias gl="git log"
alias ga="git add -A"
alias gc="git commit"

# Tmux
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias tls="tmux list-sessions"
alias tk="tmux kill-session -t"

# check updates
alias checksyu="curl -s https://www.archlinux.org/feeds/news/ | xmllint --xpath //item/title\ \|\ //item/pubDate /dev/stdin | sed -r -e 's:<title>([^<]*?)</title><pubDate>([^<]*?)</pubDate>:\2\t\1\n:g'"

export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

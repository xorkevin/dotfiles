# Executes commands at the start of an interactive session.

source $HOME/.zsh_plugins.sh

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Treat the '!' character specially during expansion.
setopt BANG_HIST
# Write the history file in the ':start:elapsed;command' format.
setopt EXTENDED_HISTORY
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
# Share history between all sessions.
setopt SHARE_HISTORY
# Expire a duplicate event first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST
# Do not record an event that was just recorded again.
setopt HIST_IGNORE_DUPS
# Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_ALL_DUPS
# Do not display a previously found event.
setopt HIST_FIND_NO_DUPS
# Do not record an event starting with a space.
setopt HIST_IGNORE_SPACE
# Do not write a duplicate event to the history file.
setopt HIST_SAVE_NO_DUPS
# Do not execute immediately upon history expansion.
setopt HIST_VERIFY

HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"  # The path to the history file.
HISTSIZE=10000                   # The maximum number of events to save in the internal history.
SAVEHIST=10000

alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# Push the old directory onto the stack on cd.
setopt AUTO_PUSHD
# Do not store duplicates in the stack.
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after pushd or popd.
setopt PUSHD_SILENT
# Push to home directory when no argument is given.
setopt PUSHD_TO_HOME
# Change directory to a path stored in a variable.
setopt CDABLE_VARS
# Write to multiple descriptors.
setopt MULTIOS
# Use extended globbing syntax.
setopt EXTENDED_GLOB
# Do not overwrite existing files with > and >>.
# Use >! and >>! to bypass.
unsetopt CLOBBER

alias d='dirs -v'

# Complete from both ends of a word.
setopt COMPLETE_IN_WORD
# Move cursor to the end of a completed word.
setopt ALWAYS_TO_END
# Perform path search even on command names with slashes.
setopt PATH_DIRS
# Show completion menu on a successive tab press.
setopt AUTO_MENU
# Automatically list choices on ambiguous completion.
setopt AUTO_LIST
# If completed parameter is a directory, add a trailing slash.
setopt AUTO_PARAM_SLASH
# Needed for file modification glob modifiers with compinit
setopt EXTENDED_GLOB
# Do not autoselect the first completion entry.
unsetopt MENU_COMPLETE
# Disable start/stop characters in shell editor.
unsetopt FLOW_CONTROL

autoload -Uz compinit
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
  compinit -i -C
else
  compinit -i
fi
unset _comp_files

bindkey -v
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char
bindkey "^U" backward-kill-line
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "$terminfo[kcbt]" reverse-menu-complete
bindkey "^L" clear-screen
bindkey "$terminfo[kcub1]" backward-char
bindkey "$terminfo[kcuf1]" forward-char

# Safe ops. Ask the user before doing anything destructive.
alias rm="${aliases[rm]:-rm} -i"
alias mv="${aliases[mv]:-mv} -i"
alias cp="${aliases[cp]:-cp} -i"
alias ln="${aliases[ln]:-ln} -i"

if [[ -z "$LS_COLORS" ]]; then
  if [[ -s "$HOME/.dir_colors" ]]; then
    eval "$(dircolors --sh "$HOME/.dir_colors")"
  else
    eval "$(dircolors --sh)"
  fi
fi
alias ls="${aliases[ls]:-ls} --group-directories-first --color=auto"

export GREP_COLOR='37;45'
export GREP_COLORS="mt=$GREP_COLOR"
alias grep="${aliases[grep]:-grep} --color=auto"

alias get='wget --continue --progress=bar --timestamping'

alias clip="xclip -selection c"
alias sx="maim -s ~/screenshot.png"
alias sc="scrot -c -d 5 ~/screenshot.png"

# Neovim
alias vim="nvim"
alias vi="nvim"

# Emacs
alias emacs="emacs -nw"

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

# observe
observe() { while inotifywait --exclude .git -e modify -r .; do $@; done; }

export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

export FZF_DEFAULT_COMMAND="rg --files --hidden --smart-case --glob '!{.git}/*'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# opam configuration
test -r $HOME/.opam/opam-init/init.zsh && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

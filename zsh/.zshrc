. $HOME/.zsh_plugins.sh

if [ -f "$HOME/.base16_theme" ]; then
  . "$HOME/.base16_theme"
fi

if command -v starship > /dev/null; then
  eval "$(starship init zsh)"
fi

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
HISTSIZE=20000                   # The maximum number of events to save in the internal history.
SAVEHIST=20000

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
_comp_path="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
# #q expands globs in conditional expressions
if [[ $_comp_path(#qNmh-20) ]]; then
  compinit -C -d "$_comp_path"
else
  mkdir -p "${_comp_path%/*}"
  compinit -i -d "$_comp_path"
fi
unset _comp_path

# Use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Increase the number of errors based on the length of the typed word. But make
# sure to cap (at 7) the max-errors to avoid hanging.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

# Don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directories
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Environment Variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# Populate hostname completion.
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#${_etc_host_ignores:+|${(j:|:)~_etc_host_ignores}})*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

# Ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# Media Players
zstyle ':completion:*:*:mpg123:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:mpg321:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:ogg123:*' file-patterns '*.(ogg|OGG|flac):ogg\ files *(-/):directories'
zstyle ':completion:*:*:mocp:*' file-patterns '*.(wav|WAV|mp3|MP3|ogg|OGG|flac):ogg\ files *(-/):directories'

# SSH/SCP/RSYNC
zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

export WORDCHARS='*?.[]~&;!#$%^(){}<>'

bindkey -v
bindkey "^?" backward-delete-char # backspace
bindkey "^W" backward-kill-word # ctrl w
bindkey '^H' backward-kill-word # ctrl backspace

bindkey "\e[1;5C" forward-word # ctrl right
bindkey "\e[1;5D" backward-word # ctrl left
# urxvt
bindkey "\eOc" forward-word # ctrl right
bindkey "\eOd" backward-word # ctrl left

# urxvt
bindkey "\e[3~" delete-char # delete

bindkey "\e[3;5~" kill-word # ctrl delete
# urxvt
bindkey "\e[3^" kill-word # ctrl delete

bindkey "^U" backward-kill-line # ctrl u

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
observe() { while inotifywait --exclude .git -e modify -r -qq .; do $@; done; }

latexgenpdf() { latexmk -pdf -bibtex -pdflatex='pdflatex -interaction=nonstopmode' $@ }

npmpkglatest() {
  local file=${1:-package.json}
  cat $file | jq -r '(.dependencies // {}, .devDependencies // {}) | keys[]' | xargs -I{} sh -c 'printf " {}@latest"'
}

export GPG_TTY=$(tty)

# password store
export PASSWORD_STORE_DIR=$HOME/.password-store
export PASSWORD_STORE_GENERATED_LENGTH=32
export PASSWORD_STORE_SIGNING_KEY=E3F7F98150B8366CE19D0F0B3920F75DE27E4A5B

export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

export BAT_THEME='base16'
export BAT_STYLE='header,grid,numbers'
export FZF_DEFAULT_COMMAND="fd --hidden --type f --exclude '.git/'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--reverse"
export FZF_CTRL_T_OPTS="--reverse --preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --color=always -r :\$FZF_PREVIEW_LINES {} || head -\$FZF_PREVIEW_LINES {}) 2> /dev/null'"
export FZF_ALT_C_OPTS="--reverse"
[ -f /usr/share/fzf/key-bindings.zsh ] && . /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && . /usr/share/fzf/completion.zsh

# opam configuration
[ -r $HOME/.opam/opam-init/init.zsh ] && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

if command -v kubectl > /dev/null; then
  __KUBECTL_COMPLETION_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/completion/kubectl_completion"
  if [ ! -f $__KUBECTL_COMPLETION_FILE ] || [ ! -s $__KUBECTL_COMPLETION_FILE ]; then
      mkdir -p "${__KUBECTL_COMPLETION_FILE%/*}"
      kubectl completion zsh >| $__KUBECTL_COMPLETION_FILE
  fi
  [ -f $__KUBECTL_COMPLETION_FILE ] && . $__KUBECTL_COMPLETION_FILE
  unset __KUBECTL_COMPLETION_FILE
fi

if [ -d $HOME/.zsh.d ]; then
  for file in $HOME/.zsh.d/*(N.); do
    . "$file"
  done
fi

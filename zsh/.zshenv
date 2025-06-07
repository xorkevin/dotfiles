# Temporary Files
if [ ! -d "$TMPDIR" ]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

export TMPPREFIX="${TMPDIR%/}/zsh"

# Language
if [ -z "$LANG" ]; then
  export LANG='en_US.UTF-8'
fi

# Editors and Pagers
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# Paths
# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

export GOPATH=$HOME/go
path=($path "$GOPATH/bin" "$HOME/.cargo/bin")
export YARN_GLOBAL_FOLDER="${XDG_DATA_HOME:-$HOME/.local/share}/yarn/berry"

export GPG_TTY=$(tty)

if [ -z "$SSH_AUTH_SOCK" ]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

# password store
export PASSWORD_STORE_DIR=$HOME/.password-store
export PASSWORD_STORE_GENERATED_LENGTH=32
export PASSWORD_STORE_SIGNING_KEY=E3F7F98150B8366CE19D0F0B3920F75DE27E4A5B

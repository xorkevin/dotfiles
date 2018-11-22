# Executes commands at login post-zshrc.

# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# Execute code only if STDERR is bound to a TTY.
[[ -o INTERACTIVE && -t 2 && ! $TMUX ]] && {

  if (( $+commands[hostname] )); then
    if (( $+commands[figlet] )); then
      hostname | figlet
      print
    else
      hostname
      print
    fi
  fi

  # Print a random, hopefully interesting, adage.
  if (( $+commands[fortune] )); then
    fortune -s
    print
  fi

  if (( $+commands[whoami] )); then
    echo "Welcome, $(whoami)"
    print
  fi

} >&2

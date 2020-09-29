{
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [ -s "$zcompdump" ] && [ \( ! -s "${zcompdump}.zwc" \) -o \( "$zcompdump" -nt "${zcompdump}.zwc" \) ]; then
    zcompile "$zcompdump"
  fi
} &!

# Execute code only if STDERR is bound to a TTY.
if [[ -o INTERACTIVE && -t 2 ]]; then
  (
  if command -v hostname > /dev/null; then
    if command -v figlet > /dev/null; then
      hostname | figlet
      print
    else
      hostname
      print
    fi
  fi

  if command -v fortune > /dev/null; then
    fortune -s
    print
  fi

  if command -v whoami > /dev/null; then
    echo "Welcome, $(whoami)"
    print
  fi
  ) 1>&2
fi

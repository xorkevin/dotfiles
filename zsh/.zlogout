# Execute code only if STDERR is bound to a TTY.
if [[ -o INTERACTIVE && -t 2 ]]; then
  if command -v whoami > /dev/null; then
    echo "Farewell, $(whoami)" >&2
  fi
fi

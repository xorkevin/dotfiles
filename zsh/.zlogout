#
# Executes commands at logout.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Execute code only if STDERR is bound to a TTY.
[[ -o INTERACTIVE && -t 2 ]] && {

  # Print the message
  if (( $+commands[whoami] )); then
    echo "Farewell, $(whoami)"
    print
  fi

} >&2

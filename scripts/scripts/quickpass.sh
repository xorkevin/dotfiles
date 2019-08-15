selected_password=$(pass git ls-files '*.gpg' | sed 's/.gpg$//' | fzf --reverse --header="Select pass:")
if [ -z "${selected_password}" ]; then
  exit
else
  pass -c ${selected_password}
  sleep 15
fi

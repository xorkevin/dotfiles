#!/bin/sh

set -e

selected_entry=$(systemctl reboot --boot-loader-entry=help | fzf --reverse --header="Select boot loader entry:")
if [ -z "$selected_entry" ]; then
  exit
else
  systemctl reboot --boot-loader-entry="$selected_entry"
fi

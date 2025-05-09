#!/usr/bin/bash

# $() is no longer valid inside hyprland configuration files.

# echo "params: $1 and $2 and $3"

if [ "$(hyprctl activewindow -j | jq -r .floating)" = "true" ]; then
  hyprctl dispatch moveactive "$1" "$2"
else
  hyprctl dispatch movewindow "$3"
fi

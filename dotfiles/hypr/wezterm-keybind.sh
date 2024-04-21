CONFIG=~/.config/wezterm/keymaps/keymaps.lua

KEYBINDS=$(rg -oP '(?<=bind = ).*' $CONFIG)

echo "$KEYBINDS"

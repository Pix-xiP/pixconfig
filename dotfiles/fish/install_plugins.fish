echo "Installing fish plugins for this"

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

for f in (cat ./bak.fish_plugins)
    echo "Installing $f"
    fisher install $f
end

echo "Configuring Tide!"

tide configure --auto --style=Rainbow --prompt_colors='16 colors' --show_time='24-hour format' --rainbow_prompt_separators=Slanted --powerline_prompt_heads=Sharp --powerline_prompt_tails=Round --powerline_prompt_style='Two lines, frame' --prompt_connection=Solid --powerline_right_prompt_frame=Yes --prompt_spacing=Compact --icons='Many icons' --transient=No

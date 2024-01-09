echo "Installing fish plugins for this"

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

for f in (cat ./bak.fish_plugins)
    echo "Installing $f"
    fisher install $f
end

# This file is to be loaded when inside a Darwin based system.
# Contains setups, functions and aliases specific to this environment.
if status is-interactive
    /opt/homebrew/bin/brew shellenv | source
end

test -f $__fish_config_dir/pix/work.fish; and source $__fish_config_dir/pix/work.fish

set -gx DOCKER_DEFAULT_PLATFORM linux/amd64
set -gx WEZTERM_CONFIG_FILE "$HOME/.config/wezterm/wezterm.lua"
set -gx GOPATH /Users/pix/AdeptusCustodes/Ultramar/
set -gx GOROOT /opt/homebrew/opt/go/libexec
set -x LLVM_CONFIG /opt/homebrew/Cellar/llvm/18.1.8/bin/llvm-config
set -gx LUA_INIT "@/Users/pix/.config/lua/init.lua"

fish_add_path -a $GOPATH/bin $HOME/.cargo/bin /opt/homebrew/bin

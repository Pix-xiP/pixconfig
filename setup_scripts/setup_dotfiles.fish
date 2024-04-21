#!/usr/bin/env fish
#
# Lets setup the dotfiles.

set CURR (pwd)
echo $CURR

set DOTFILES $CURR/../dotfiles
echo $DOTFILES

set CONFIG ~/.config
cd $CONFIG || exit 1

for dotconfig in (ls $DOTFILES)
    echo $config
    echo "ln -s $DOTFILES/$dotconfig $CONFIG/$dotconfig"
    ln -s $DOTFILES/$dotconfig $CONFIG/$dotconfig
end

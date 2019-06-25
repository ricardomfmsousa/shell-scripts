#!/bin/bash
# Copy dotfiles and perform some cleanup

source ../functions/utils.sh && no-root

# Copy all configuration files under the dotfiles folder
gecho "Copying dotfiles"
DOTFILES_DIR="../dotfiles" &&
cp -r $DOTFILES_DIR/. $HOME &&
echo "Copied $(ls -Al $DOTFILES_DIR)" &&

# Load tilix config in dconf (dconf dump /com/gexperts/Tilix/ > $HOME/.tilix)
gecho "Loading Tilix dconf configuration" &&
dconf load /com/gexperts/Tilix/ < $HOME/.tilix &&

# Clean dependencies
gecho "Removing uneeded dependencies" &&
sudo apt autoremove 
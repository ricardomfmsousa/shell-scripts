#!/bin/bash
# Copy dotfiles and perform some cleanup
source ../functions/utils.sh && no-root

# Copy all configuration files under the dotfiles folder
gecho "Copying dotfiles"
DOTFILES_DIR="../dotfiles" &&
cp -r $DOTFILES_DIR/. $HOME &&
echo "Copied $(ls -Al $DOTFILES_DIR)" &&

# Clean dependencies
gecho "Removing uneeded dependencies" &&
sudo apt autoremove 
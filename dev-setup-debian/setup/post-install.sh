#!/bin/bash
# Copy dotfiles and perform some cleanup
source ../functions/utils.sh && no-root

gecho "Copying dotfiles"
DOTFILES_DIR="../dotfiles" && \
cp -r $DOTFILES_DIR/. $HOME && \
echo "Copied $(ls -Al $DOTFILES_DIR)" && \

gecho "Removing uneeded dependencies" && \
sudo apt autoremove 
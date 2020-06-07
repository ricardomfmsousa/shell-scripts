#!/usr/bin/env bash
# Copy dotfiles and perform some cleanup

source ./functions/utils.sh && no-root

# Copy all configuration files under the dotfiles folder
gecho "Copying dotfiles"
DOTFILES_DIR="dotfiles"
cp -r $DOTFILES_DIR/. $HOME
echo "Copied $(ls -Al $DOTFILES_DIR)"

# Increase the amount of inotify watchers
# https://github.com/angular/angular-cli/issues/8168
# https://github.com/guard/listen/wiki/Increasing-the-amount-of-inotify-watchers
gecho "Updating inotify watchers"
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Clean dependencies
gecho "Removing unneeded dependencies"
sudo apt autoremove

# TODO: create swap file, enable it and configure swapiness

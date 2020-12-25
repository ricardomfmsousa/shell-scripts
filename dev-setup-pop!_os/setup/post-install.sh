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

# Fix VPN DNS servers
# https://blog.javinator9889.com/strongswan-dns-servers/
gecho "Applying fix for StrongSwan VPN not updating DNS servers in systemd distros"
echo "Stopping systemd-resolved service"
sudo systemctl stop systemd-resolved
echo "Disabling systemd-resolved - now NetworkManager manages the connections"
sudo systemctl disable systemd-resolved
echo "Enabling NetworkManager DNS resolution"
sudo echo "\
[main]
plugins=ifupdown,keyfile
dns=default

[ifupdown]
managed=false

[device]
wifi.scan-rand-mac-address=no" | sudo tee /etc/NetworkManager/NetworkManager.conf
echo "Removing old resolv.conf"
sudo rm -f /etc/resolv.conf
echo "Updating resolv.conf with latest changes"
sudo systemctl restart NetworkManager

# Clean dependencies
gecho "Removing unneeded dependencies"
sudo apt autoremove -y

# TODO: create swap file, enable it and configure swapiness

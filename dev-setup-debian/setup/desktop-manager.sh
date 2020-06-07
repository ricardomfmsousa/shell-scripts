#!/usr/bin/env bash
# Setup desktop manager look and feel with specific packages and configs

source ./functions/utils.sh && no-root

gecho "Updating gnome configs"

# Install tweaks and extensions
apt-install \
  gnome-tweaks gir1.2-gtop-2.0 \
  gnome-shell-extension-weather \
  gnome-shell-extension-system-monitor

# Apply custom gnome settings
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

becho "Done"

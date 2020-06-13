#!/usr/bin/env bash
# Setup desktop manager look and feel with specific packages and configs

source ./functions/utils.sh && no-root

gecho "Updating gnome configs"

# Install tweaks and extensions
apt-install \
  gnome-tweaks gir1.2-gtop-2.0 \
  gnome-shell-extension-system-monitor

# Apply custom gnome settings
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

# Add custom keybindings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
  "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"
# F1: trigger tilix in quake mode
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "'Tilix'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "'F1'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "'tilix --quake'"
# Super + PrintScreen: trigger flameshot print screen utility
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "'Flameshot'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "'<Super>Print'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "'flameshot gui'"
##

# Add dock favourites
gsettings set org.gnome.shell favorite-apps \
  "['google-chrome.desktop', 'firefox.desktop', 'opera.desktop', 'discord.desktop', 'org.gnome.Geary.desktop', 'code.desktop', 'mongodb-compass.desktop', \
  'com.getpostman.Postman.desktop', 'dockstation.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'io.elementary.appcenter.desktop']"


becho "Done"

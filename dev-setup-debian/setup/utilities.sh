#!/bin/bash
# Install miscellaneous utilities
source ../functions/utils.sh && no-root

PACKAGES=(
  # Package managers
  snap gdebi
  # Runtimes, codecs, fonts and plugins that are restricted in some countries 
  libavcodec-extra libdvd-pkg
  ubuntu-restricted-extras ubuntu-restricted-addons fonts-powerline
  # Build essentials 
  build-essential libssl-dev libstdc++6
  # System monitor and power management
  htop stacer tlp tlp-rdw
  # Partition tools
  gparted usb-creator-gtk
  # FTP client
  filezilla
  # Graphics
  flameshot gimp gimp-data gimp-plugin-registry 
  gimp-data-extras inkscape imagemagick
  # Video
  kazam cheese vlc
  # Fonts
  fonts-powerline
  # Download manager / Torrent client
  curl wget transmission
  # Archive Extractors
  unace unrar zip unzip p7zip-full p7zip-rar sharutils
  rar uudeview mpack arj cabextract file-roller
  # Desktop configuration tweaks
  gnome-tweaks
  # Mouse themes
  breeze-cursor-theme oxygen-cursor-theme oxygen-cursor-theme-extra
)
sudo apt install -y ${PACKAGES[@]} && \

# Install snap packages
# API tester
sudo snap install postman && \
# Graphics
sudo snap install krita && \
sudo snap install pick-colour-picker && \
# Audio
sudo snap install audacity && \
sudo snap install spotify && \
# Comunications
sudo snap install discord && \
sudo snap install skype --classic

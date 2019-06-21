#!/bin/bash
# Install miscellaneous utilities
source ../functions/utils.sh && no-root

# System monitor and optimizer
apt-install-ppa "oguzhaninan/stacer" "stacer" && 

APT=(
  # Package managers, PPAs
  snap snapd gdebi software-properties-common
  # Runtimes, codecs, fonts and plugins that are restricted in some countries 
  ubuntu-restricted-extras ubuntu-restricted-addons
  # Codecs
  libavcodec-extra ffmpeg libdvd-pkg
  # Build essentials 
  build-essential libssl-dev libstdc++6
  # System info, monitor and power management
  neofetch htop tlp tlp-rdw
  # Partition tools
  gparted usb-creator-gtk
  # FTP client
  filezilla
  # Office
  libreoffice
  # Graphics
  flameshot gimp gimp-data gimp-plugin-registry 
  gimp-data-extras inkscape imagemagick
  # Video
  kazam cheese vlc browser-plugin-vlc
  # Fonts
  fonts-powerline fonts-liberation
  # Download manager / Torrent client
  curl wget transmission
  # Archive Extractors
  unace unrar zip unzip p7zip-full p7zip-rar sharutils
  rar uudeview mpack arj cabextract file-roller
  # Mouse themes
  breeze-cursor-theme oxygen-cursor-theme oxygen-cursor-theme-extra
) && 
apt-install ${APT[@]} &&

SNAP=(
  # API tester
  postman 
  # Graphics
  krita pick-colour-picker 
  # Audio
  audacity spotify 
  # Comunications
  discord skype
) &&
snap-install ${SNAP[@]}

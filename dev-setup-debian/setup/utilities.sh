#!/bin/bash
# Install miscellaneous utilities

source ../functions/utils.sh && no-root

APT=(
  # Codecs
  libavcodec-extra ffmpeg
  # Build essentials 
  build-essential libssl-dev libstdc++6
  # System info, monitor and power management
  neofetch htop tlp tlp-rdw
  # Partition tools
  gparted
  # FTP client
  filezilla
  # Office
  libreoffice
  # Graphics
  gimp gimp-data gimp-plugin-registry 
  gimp-data-extras inkscape imagemagick
  # Video
  kazam cheese vlc
  # Fonts
  fonts-powerline fonts-liberation
  # Download manager / Torrent client
  curl wget transmission
  # Archive Extractors
  unace unrar zip unzip p7zip-full p7zip-rar sharutils
  rar uudeview mpack arj cabextract file-roller
) && 
apt-install ${APT[@]} &&

SNAP=(
  # API tester
  postman 
  # Graphics
  flameshot-app krita pick-colour-picker 
  # Audio
  audacity spotify 
  # Comunications
  discord skype
) &&
snap-install ${SNAP[@]}

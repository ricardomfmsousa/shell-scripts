#!/usr/bin/env bash
# Install miscellaneous utilities

source ./functions/utils.sh && no-root

PKGS=(
  # Codecs
  libavcodec-extra ffmpeg
  # Build essentials 
  build-essential libssl-dev libstdc++6
  # System info, monitor
  neofetch htop
  # Partition tools
  gparted exfat-utils exfat-fuse
  # FTP client
  filezilla
  # Office
  libreoffice
  # Graphics
  krita gimp gimp-data gimp-plugin-registry 
  gimp-data-extras inkscape imagemagick flameshot
  # Audio
  audacity
  # Video
  kazam cheese vlc
  # Fonts
  fonts-powerline fonts-liberation
  # Download manager / Torrent client
  curl wget transmission
  # Archive Extractors
  unace unrar zip unzip p7zip-full p7zip-rar sharutils
  rar uudeview mpack arj cabextract file-roller
  # Comunications
  discord 
) 
apt-install ${PKGS[@]}

PKGS=(
  # API tester
  com.getpostman.Postman 
  # Color picker
  nl.hjdskes.gcolor3
  # Comunications
  com.skype.Client
)
flatpack-install ${PKGS[@]}

# Download a powerline mono spaced font version
sudo wget --content-disposition -N -P /usr/share/fonts/ \
http://github.com/abertsch/Menlo-for-Powerline/blob/master/Menlo%20for%20Powerline.ttf?raw=true
sudo fc-cache -vf /usr/share/fonts/


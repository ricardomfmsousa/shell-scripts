#!/usr/bin/env bash
# Setup web browsers

source ./functions/utils.sh && no-root

# Add Brave web browser repository
#   Free and open-source privacy focused web browser by Brave Software,
#   founded by the creator of Javascript and former CEO of Mozilla Corporation
apt-install apt-transport-https curl
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc |
  sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" |
  sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update

PKGS=(
  firefox # Free and open-source web browser developed by Mozilla
  chromium # Open-source version of Google Chrome
  brave-browser # Chromium-based open-source privacy focused web browser
)
apt-install ${PKGS[@]}

# Install latest Google Chrome
download-install-deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"




#!/bin/bash
# Setup web browsers
source ../functions/utils.sh && no-root

APT=(
  chromium-browser
  firefox
)
apt-install ${APT[@]} &&

SNAP=(
  opera
)
snap-install ${SNAP[@]} &&

# Install latest Google Chrome
download-install-deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

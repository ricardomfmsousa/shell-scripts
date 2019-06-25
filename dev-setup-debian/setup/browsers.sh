#!/bin/bash
# Setup web browsers

source ../functions/utils.sh && no-root

APT=(
  chromium-browser # Google's open-source web browser
  firefox # Mozilla Foundation open-source web browser
) &&
apt-install ${APT[@]} &&

SNAP=(
  opera # Opera Software web browser
) &&
snap-install ${SNAP[@]} &&

# Install latest Google Chrome
download-install-deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

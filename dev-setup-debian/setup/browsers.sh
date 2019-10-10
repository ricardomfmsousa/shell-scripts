#!/bin/bash
# Setup web browsers

source ../functions/utils.sh && no-root

SNAP=(
  chromium # Open-source version of Google Chrome
  opera # Opera Software web browser
) &&
snap-install ${SNAP[@]} &&

# Install latest Google Chrome
download-install-deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

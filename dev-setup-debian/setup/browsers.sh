#!/bin/bash
# Setup web browsers
source ../functions/utils.sh && no-root

# Install Chromium, Firefox and opera
sudo apt install -y chromium-browser firefox && \
sudo snap install opera && \

# Install latest Google Chrome
download-install-deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

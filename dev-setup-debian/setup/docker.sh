#!/bin/bash
# Setup docker, docker-compose, rancher and openshift
source ../functions/utils.sh && no-root

# Install docker main tools
gecho "Installing docker tools"
PACKAGES=(
  docker # Container platform
  docker-compose # Define and run multi-container Docker applications
  dockstation # Manage projects based on Docker
)
sudo apt install -y ${PACKAGES[@]} && \

# Install openshift CLI
gecho "Installing openshift CLI" && \
INSTALL_TO="$HOME/.oc" && \
git-download-latest-release "openshift/origin" "$INSTALL_TO" && \
add-to-path "$INSTALL_TO" && \

# Install rancher CLI
gecho "Installing rancher CLI" && \
INSTALL_TO="$HOME/.rancher" && \
git-download-latest-release "rancher/cli" "$INSTALL_TO"  && \
add-to-path "$INSTALL_TO"

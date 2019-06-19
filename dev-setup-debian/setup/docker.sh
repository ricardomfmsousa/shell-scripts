#!/bin/bash
# Setup docker, docker-compose, rancher and openshift
source ../functions/utils.sh && no-root

# Install main docker tools
gecho "Installing docker tools"
PACKAGES=(
  docker # Container platform
  docker-compose # Define and run multi-container Docker applications
)
sudo apt install -y ${PACKAGES[@]} && \

# Install latest Dockstation: Manage projects based on Docker
gecho "Installing Dockstation" && \
LATEST_VERSION=`git-read-latest-release DockStation/dockstation | cut -dv -f2` && \
download-install-deb \
"https://github.com/DockStation/dockstation/releases/download/v${LATEST_VERSION}/dockstation_${LATEST_VERSION}_amd64.deb" && \

# Install latest openshift CLI
gecho "Installing openshift CLI" && \
INSTALL_TO="$HOME/.oc" && \
git-download-latest-release "openshift/origin" "$INSTALL_TO" && \
add-to-path "$INSTALL_TO" && \

# Install latest rancher CLI
gecho "Installing rancher CLI" && \
INSTALL_TO="$HOME/.rancher" && \
git-download-latest-release "rancher/cli" "$INSTALL_TO"  && \
add-to-path "$INSTALL_TO"
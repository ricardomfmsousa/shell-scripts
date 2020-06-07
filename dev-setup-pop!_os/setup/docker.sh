#!/usr/bin/env bash
# Setup docker, docker-compose, rancher and openshift

source ./functions/utils.sh && no-root

# Install latest main docker tools
gecho "Installing docker tools"
# Dependencies to install docker 
PKGS=(
  apt-transport-https
  ca-certificates
  curl
  gnupg2
  software-properties-common
)
apt-install ${PKGS[@]}

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
# Add the official docker repo
sudo add-apt-repository -y \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable"
sudo apt update
gecho "Installing docker-ce"
sudo apt install -y docker-ce
# Run docker without sudo
sudo usermod -aG docker $USER

# Install docker compose
gecho "Installing docker-compose"
DOCKER_COMPOSE_LATEST=`git-read-latest-release docker/compose`
sudo curl -L https://github.com/docker/compose/releases/download/\
$DOCKER_COMPOSE_LATEST/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install latest Openshift CLI
gecho "Installing openshift CLI"
INSTALL_TO="$HOME/.oc"
OC_DIR="openshift-origin-client-tools-v3.6.0-alpha.2-3c221d5-linux-64bit"
wget "https://github.com/openshift/origin/releases/download/v3.6.0-alpha.2/$OC_DIR.tar.gz"
tar -zxf "$OC_DIR.tar.gz"
rm -rf "$OC_DIR.tar.gz" "$INSTALL_TO"
mv -f "$OC_DIR" "$INSTALL_TO"
add-to-path "$INSTALL_TO"

# Install latest Dockstation: Manage projects based on Docker
gecho "Installing Dockstation"
LATEST_VERSION=`git-read-latest-release DockStation/dockstation | cut -dv -f2`
download-install-deb "https://github.com/DockStation/dockstation/releases/\
download/v${LATEST_VERSION}/dockstation_${LATEST_VERSION}_amd64.deb"
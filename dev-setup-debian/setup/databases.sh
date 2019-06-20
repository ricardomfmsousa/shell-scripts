#!/bin/bash
# Setup all databases and its GUIs
source ../functions/utils.sh && no-root

APT=(
  mongodb # Cross-platform document-oriented database program
  mongodb-clients
)
apt-install ${APT[@]} &&

SNAP=(
  robo3t-snap # Lightweight GUI for MongoDB
)
snap-install ${SNAP[@]} &&

# MongoDB is configured to start automatically with the server, disable it
sudo systemctl disable mongodb &&

# Install NoSQLBooster: shell-centric cross-platform GUI tool for MongoDB
INSTALL_DIR="$HOME/.appimage" &&
APP_NAME="nosqlbooster4mongo-5.1.8.AppImage" &&
mkdir -p $INSTALL_DIR &&
wget https://nosqlbooster.com/s3/download/releasesv5/$APP_NAME -P $INSTALL_DIR &&
sudo chmod +x $INSTALL_DIR/$APP_NAME &&
# Run the app just enough to index it
$INSTALL_DIR/$APP_NAME & sleep 5 && kill -9 $!
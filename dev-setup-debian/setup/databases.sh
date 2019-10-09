#!/bin/bash
# Setup all databases and its GUIs

source ../functions/utils.sh && no-root

APT=(
  mongodb # Cross-platform document-oriented database program
  mongodb-clients # Client apps for mongodb
) &&
apt-install ${APT[@]} &&

SNAP=(
  robo3t-snap # Lightweight GUI for MongoDB
) &&
snap-install ${SNAP[@]} &&

# MongoDB is configured to start automatically with the server, disable it
sudo systemctl disable mongodb &&

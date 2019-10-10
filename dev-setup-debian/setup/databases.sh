#!/bin/bash
# Setup all databases and its GUIs

source ../functions/utils.sh && no-root

SNAP=(
  mongo32 # NoSQL document based database
  robo3t-snap # Lightweight GUI for MongoDB
) &&
snap-install ${SNAP[@]}

# Disable Wayland server for robo3t to work
sudo sed -i '/WaylandEnable=false/s/^#//g' /etc/gdm3/daemon.conf

#!/bin/bash
# Runs all scripts under the setup directory, those can also be run individually

source ./functions/utils.sh && no-root

# Declare which setup files to run, under the setup directory
SETUP_DIR="./setup"
SETUP_FILES=(
 utilities.sh # General system, image, video, audio and other tools
 browsers.sh # Setup web browsers
 databases.sh # Setup all databases and its GUIs
 docker.sh # Setup docker, docker-compose, rancher and openshift
 java.sh # Setup Java and Java versions manager
 javascript.sh # Configure NVM, Node.js and node packages
 network.sh # Setup network and install certificates
 shell-vcs-ide.sh # Setup all related shell, terminal, VCS and editor software
 os.sh # Setup OS/WM specific packages and configs
 post-install.sh # Copy dotfiles and perform some cleanup
)

# Update apt package list and upgrade upgradable packages
gecho "Upgrading existing apt packages"
sudo apt update && sudo apt upgrade -y &&

# Run the setup scripts
cd $SETUP_DIR && \
for setup in ${SETUP_FILES[@]}; do 
  becho "Running $setup"
  apt-wait
  # Warn and exit immediately if child script errors 
  ./$setup
  [ $? -ne 0 ] && recho "Error in $setup" && exit $?
done &&
cd -

# TODO: create swap file and configure swapiness

gecho "Setup success!"

# Reboot
becho "Press enter to REBOOT, Ctrl+C to cancel."; read -p ""

#!/usr/bin/env bash
# Runs all scripts under the setup directory, those can also be run individually

source ./functions/utils.sh && no-root

# Declare which setup files to run, under the setup directory
SETUP_DIR="setup"
SETUP_FILES=(
 utilities.sh # General system, image, video, audio and other tools
 browsers.sh # Setup web browsers
 databases.sh # Setup all databases and its GUIs
 docker.sh # Setup docker, docker-compose and container application platforms
 java.sh # Setup Java and Java versions manager
 javascript.sh # Configure NVM, Node.js and node packages
 network.sh # Setup network and install certificates
 shell-vcs-ide.sh # Setup all related shell, terminal, VCS and editor software
 desktop-manager.sh # Setup DM specific packages and configs
 post-install.sh # Copy dotfiles and perform some cleanup
)

# Run the setup scripts
for setup in ${SETUP_FILES[@]}; do 
  becho "Running $setup"
  # Warn and exit immediately if child script errors 
  "$SETUP_DIR"/./"$setup"
  [ $? -ne 0 ] && recho "Error in $setup" && exit $?
done

# Reboot
gecho "Setup success!"
becho "Press enter to REBOOT, Ctrl+C to cancel."; read -p ""
sudo reboot

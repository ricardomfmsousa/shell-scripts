#!/usr/bin/env bash
# Sets up a web development environment by running all scripts located under the
# `setup` directory *(all scripts can also be run individually)*

source ./functions/base-utils.sh && no-root

# Display informations and perform all questions, setting further needed
# variables in advance, to run all the setup script non-interactively
clear
becho "************************************************"
gecho " This script will install and configure common"
gecho " core software tools for web development."
echo
gecho " It has been tested in Pop!_OS 20.04 but it"
gecho " should also work in Ubuntu and derivates."
becho "************************************************"
read -e -p "Enter your git username: " -i "$(whoami)" GIT_USER_NAME
read -e -p "Enter your git email: " GIT_USER_EMAIL
export GIT_USER_NAME="$GIT_USER_NAME"
export GIT_USER_EMAIL="$GIT_USER_EMAIL"
becho "Press [ENTER] to start the setup, [Ctrl+C] to cancel."; read -p ""

# Count how much time the setup script took to finish
SECONDS=0

source ./functions/utils.sh

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
  chmod +x "$SETUP_DIR/$setup"
  # Warn and exit immediately if child script errors 
  "$SETUP_DIR/$setup"
  [ $? -ne 0 ] && recho "Error in $setup" && exit $?
done

gecho "Done with success!"
gecho "Setup finished in $(($SECONDS / 60)) minutes and $(($SECONDS % 60)) seconds."

# Reboot
becho "Press [ENTER] to reboot, [Ctrl+C] to cancel."; read -p ""
sudo reboot

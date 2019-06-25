#!/bin/bash
# Setup Node.js through NVM and install npm packages

source ../functions/utils.sh && no-root

# Needed for some npm packages that require compiling code from source
apt-install build-essential &&

# Setup nvm
rm -rf "$NVM_DIR" ~/.nvm && export NVM_DIR="" &&
LATEST_RELEASE=`git-read-latest-release "nvm-sh/nvm"` &&
gecho "Installing nvm $LATEST_RELEASE" &&
sh -c "$(curl -sL https://raw.githubusercontent.com/creationix/nvm/$LATEST_RELEASE/install.sh)" &&
source ~/.profile &&

# Install latest Node.js LTS
nvm install --lts &&

# Install mandatory node packages
gecho "Installing node packages" &&
NPM=(
  npx # Executes npm package binaries
  yarn # Fast, reliable, and secure dependency management.
  @angular/cli # A command line interface for Angular
  @vue/cli # Standard Tooling for Vue.js Development
  create-react-app # Create React apps with no build configuration
  typescript # Superset of JavaScript that compiles to clean JavaScript output
) &&
npm i -g ${NPM[@]}


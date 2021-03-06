#!/usr/bin/env bash
# Setup Node.js through NVM and install npm packages

source ./functions/utils.sh && no-root

# Setup nvm
rm -rf `printenv NVM_DIR` ~/.nvm && export NVM_DIR=""
LATEST_RELEASE=`git-read-latest-release "nvm-sh/nvm"`
gecho "Installing nvm $LATEST_RELEASE"
sh -c "$(curl -sL https://raw.githubusercontent.com/creationix/nvm/$LATEST_RELEASE/install.sh)"
source ~/.profile

# Install latest Node.js LTS and set it as default
nvm install 'lts/*'
nvm alias default 'lts/*'

# Install mandatory node packages
gecho "Installing node packages"
PKGS=(
  yarn # Fast, reliable, and secure dependency management
  @angular/cli # A command line interface for Angular
  @vue/cli # Standard Tooling for Vue.js Development
  create-react-app # Create React apps with no build configuration
  typescript # Superset of JavaScript that compiles to clean JavaScript output
  ts-node # TypeScript execution and REPL for node.js, with source map support
)
# Install globally, silently, quietly, accept defaults, anwser no all questions
yes n | npm i -g -s -q -y ${PKGS[@]} || true

# Set yarn as Angular default package manager
ng config -g cli.packageManager yarn
#!/usr/bin/env bash
# Base utility function and global variable definitions
# with no external dependencies to be sourced mainly within `utils.sh`.
# Also sets a fail first strategy and displays detailed error information
# to help in the scripts debugging.

# Exit immediately if a command exits with a non-zero status.
# Set the return value of a pipeline to the status of last command to exit with a non-zero status.
set -eo pipefail

# Print the errored script error code, name and line
trap 'rc=$?; recho "Error code $rc in $0 at line $LINENO"; exit $rc' ERR

# Disable some (text) dialogs and use default values where possible
export DEBIAN_FRONTEND=noninteractive

# Set AppImages install folder
export APP_IMAGE_FOLDER="$HOME/.local/bin"

# Set some echo wrappers to output text with colors 
recho() { echo -e "\e[1m\e[31m$1\e[0m"; }
gecho() { echo -e "\e[1m\e[32m$1\e[0m"; }
becho() { echo -e "\e[1m\e[34m$1\e[0m"; }

# Disallow running with root to prevent future file permission issues
no-root() {
  [ "$EUID" -eq 0 ] && echo "Please don't run $0 as root..." && exit 1
  return 0
}

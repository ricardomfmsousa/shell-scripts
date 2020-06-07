#!/usr/bin/env bash
# Utility functions to be used in `setup.sh`

# Exit immediately if a command exits with a non-zero status.
# Treat unset variables as an error when substituting.
# Set the return value of a pipeline to the status of last command to exit with a non-zero status.
set -euo pipefail
# Print the errored script error code, name and line
trap 'rc=$?; recho "Error code $rc in $0 at line $LINENO"; exit $rc' ERR
# Disable some (text) dialogs and use default values where possible
DEBIAN_FRONTEND=noninteractive

APP_IMAGE_FOLDER="$HOME/.local/bin"

recho() { echo -e "\e[1m\e[31m$1\e[0m"; }
gecho() { echo -e "\e[1m\e[32m$1\e[0m"; }
becho() { echo -e "\e[1m\e[34m$1\e[0m"; }

no-root() {
  [ "$EUID" -eq 0 ] && echo "Please don't run $0 as root..." && exit 1
  return 0
}

# $1: repo name
git-read-latest-release() {
  echo `curl --silent "https://api.github.com/repos/$1/releases/latest" |
    grep -Po '"tag_name": "\K.*?(?=")'`
}

# $1: repo name
# $2: folder to clone to
git-clone-latest-release() {
  rm -rf $2 && LATEST_RELEASE=`git-read-latest-release $1` &&
  git clone -b $LATEST_RELEASE --single-branch "https://github.com/$1" $2
}

# $1: repo name
# $2: folder to unpack to
git-download-latest-release() {
  rm -rf $2 && mkdir -p $2 && LATEST_RELEASE=`git-read-latest-release $1` &&
  REPO="https://github.com/$1/archive/$LATEST_RELEASE.tar.gz" &&
  echo "Downloading from $REPO, unpacking to $2" &&
  wget -q -O - $REPO | tar xz -C $2
}

# $1: directory to add to path
add-to-path() {
  # Only add if not in $PATH already
  [[ ":$PATH:" == *":$1:"* ]] && return 0
  echo 'if [ -d "'$1'" ]; then PATH="'$1':$PATH"; fi' >> $HOME/.profile &&
  sleep 1 &&
  source $HOME/.profile
}

# $1: variable name
# $2: variable value
export-var() {
  # Only export if not already defined
  [[ "$(eval echo "\$$1")" == "$2" ]] && return 0
  echo "export $1=\"$2\"" >> $HOME/.profile &&
  source $HOME/.profile
}

# $1: App/script name
# $2: App/script path
add-to-startup() {
  AUTO_START_DIR="$HOME/.config/autostart"
  AUTO_START_PATH="$AUTO_START_DIR/$1.desktop"
  mkdir -p "$AUTO_START_DIR" &&
  echo "\
[Desktop Entry]
Type=Application
X-GNOME-Autostart-enabled=true
Name=$1
Exec=$2
" > "$AUTO_START_PATH" &&
  echo "[$1] added to $AUTO_START_PATH"
}

# Wait for apt to finish it's operations
apt-wait() {
  while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
    sleep 1
  done
  while sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do
    sleep 1
  done
  if [ -f /var/log/unattended-upgrades/unattended-upgrades.log ]; then
    while sudo fuser /var/log/unattended-upgrades/unattended-upgrades.log >/dev/null 2>&1 ; do
      sleep 1
    done
  fi
}

# $@: Packages to install
apt-install() {
  packages=("$@")
  apt-wait &&
  sudo apt install -y "${packages[@]}" --install-recommends &&
  apt-wait
}

# $1: PPA name
# $2: package name
apt-install-ppa() {
  # Install software-properties-common to get add-apt-repository
  sudo add-apt-repository -y -u ppa:$1 && 
  sudo apt install -y $2
}

# $@: Snap packages to install
snap-install() {
  # Install one by one to prevent fails when in bulk and a snap exists
  packages=("$@")
  for snap in "${packages[@]}"; do
    # Dynamicaly read and set confinement
    confinement=`snap info --verbose $snap |
      awk  '/confinement:/ && !/strict/ {print a="--"$2; a;}'` &&
    sudo snap install $snap $confinement
  done
}

# $@: Flatpack packages to install
flatpack-install() {
  packages=("$@")
  flatpak install -y flathub "${packages[@]}"
}

# $1: AppImage URL to install
app-image-install() {
  mkdir -p $APP_IMAGE_FOLDER && 
  cd $_ &&
  wget $1 &&
  filename=$(basename $1) &&
  chmod a+x "$APP_IMAGE_FOLDER/$filename" &&
  cd -
}

# $1: download url 
download-install-deb() {
  DEB_NAME=`mktemp` &&
  wget -O "$DEB_NAME" "$1" && sudo gdebi -n "$DEB_NAME" && rm -f "$DEB_NAME"
}

# Install/configure packages to be used further in the install
# process, making sure all script dependecies are met
LOCK_FILE=/tmp/utils.lock
if [[ ! -f "$LOCK_FILE" ]]; then
  becho "Installing utils dependencies"
  sudo apt update && sudo apt upgrade -y && 
  apt-install \
    wget python3-pip git dirmngr build-essential gdebi snap snapd \
    gdebi software-properties-common python3-software-properties
  # Do not run this init in the current session anymore
  touch "$LOCK_FILE" &&
  becho "Utils dependencies installed."
  sleep 1
fi


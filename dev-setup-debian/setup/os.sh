#!/bin/bash
# Setup OS/WM specific packages and configs

source ../functions/utils.sh && no-root

WINDOW_MANAGER=`echo $XDG_CURRENT_DESKTOP | awk '{print tolower($0)}'`
DISTRO=`awk -F'=' '/^DISTRIB_ID/ {print tolower($2)}' /etc/*-release`
gecho "Adding packages and configs for $DISTRO - $WINDOW_MANAGER"

# Perform OS specific actions
case $DISTRO in
  *ubuntu*|*debian*)
    # Nothing to do yet...
    ;;
  *elementary*)
    # Nothing to do yet...
    ;;
  *)
    recho "Nothing to install in $DISTRO"
    ;;
esac

# Perform WM specific actions
case $WINDOW_MANAGER in
  *unity*)
    apt-install unity-tweak-tool
    ;;
  *gnome*)
    apt-install gnome-tweaks
    ;;
  *pantheon*)
    apt-install-ppa "philip.scott/elementary-tweaks" "elementary-tweaks"
    ;;
  *)
    recho "Nothing to install in $WINDOW_MANAGER"
    ;;
esac
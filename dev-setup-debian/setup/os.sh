#!/bin/bash
# Setup OS/WM specific packages and configs

source ../functions/utils.sh && no-root

DESKTOP_MANAGER=`echo $XDG_CURRENT_DESKTOP | awk '{print tolower($0)}'`
DISTRO=`awk -F'=' '/^DISTRIB_ID/ {print tolower($2)}' /etc/*-release`
gecho "Adding packages and configs for $DISTRO - $DESKTOP_MANAGER"

# Perform OS specific actions
case $DISTRO in
  *ubuntu*|*debian*)
    # Nothing to do yet...
    ;;
  *elementary*)
    # Nothing to do yet...
    ;;
  *mx*)
    # Nothing to do yet...
    ;;
  *)
    recho "Nothing to install in $DISTRO"
    ;;
esac

# Perform DM specific actions
case $DESKTOP_MANAGER in
  *unity*)
    apt-install unity-tweak-tool
    ;;
  *gnome*)
    apt-install gnome-tweaks
    ;;
  *xfce*)
    # Nothing to do yet...
    ;;
  *pantheon*)
    apt-install-ppa "philip.scott/elementary-tweaks" "elementary-tweaks"
    ;;
  *)
    recho "Nothing to install in $DESKTOP_MANAGER"
    ;;
esac

becho "Done"

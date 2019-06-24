#!/bin/bash
# Setup Java and Java version switcher
source ../functions/utils.sh && no-root

APT=(
  maven # Build automation tool used primarily for Java projects
  default-jre # Default Java Runtime
  default-jdk # Default Java Dev Kit
) &&
apt-install ${APT[@]} &&

# Install jenv to easily switch between installed java versions
JENV_INSTALL_DIR="$HOME/.jenv" &&
rm -rf $JENV_INSTALL_DIR &&
git clone https://github.com/gcuisinier/jenv.git $JENV_INSTALL_DIR

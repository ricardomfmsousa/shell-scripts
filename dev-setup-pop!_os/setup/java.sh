#!/usr/bin/env bash
# Setup Java and Java version switcher

source ./functions/utils.sh && no-root

gecho "Installing default JRE/JDK and JDK 8"
# Install OpenJDK 8 from AdoptOpenJDK APT repository
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
apt-install-ppa \
  https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
  adoptopenjdk-8-hotspot

PKGS=(
  apt-transport-https # Transitional package for https support
  ca-certificates # Common CA certificates
  wget # Retrieve files from the web
  dirmngr # GNU privacy guard - network certificate management service
  gnupg # GNU privacy guard - a free PGP replacement
  software-properties-common # Software repository manager (common)
  maven # Build automation tool used primarily for Java projects
  default-jre # Default Java Runtime
  default-jdk # Default Java Dev Kit
)
apt-install ${PKGS[@]}

gecho "Setting JVM 8 as default"
yes 1 | sudo update-alternatives --config java || true

echo "Default Java version set to:"
java -version


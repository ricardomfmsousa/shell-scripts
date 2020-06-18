#!/usr/bin/env bash
# Setup Java and Java version switcher

source ./functions/utils.sh && no-root

PKGS=(
  apt-transport-https # Transitional package for https support
  ca-certificates # Common CA certificates
  wget # Retrieve files from the web
  dirmngr # GNU privacy guard - network certificate management service
  gnupg # GNU privacy guard - a free PGP replacement
  software-properties-common # Software repository manager (common)
  maven # Build automation tool used primarily for Java projects
  openjdk-8-jre # Java 8 Runtime
  openjdk-8-jdk # Java 8 Dev Kit
  default-jre # Default Java Runtime
  default-jdk # Default Java Dev Kit
)
apt-install ${PKGS[@]}

gecho "Setting JVM 8 as default"
yes 2 | sudo update-alternatives --config java || true

echo "Default Java version set to:"
java -version


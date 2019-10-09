#!/bin/bash
# Setup network and install certificates

source ../functions/utils.sh && no-root

# Install ca-certificates, VPN IKEv2
gecho "Installing network tools"
APT=(
  ca-certificates
  strongswan 
  network-manager-strongswan
  libcharon-extra-plugins
  libstrongswan-extra-plugins
) &&
apt-install ${APT[@]} &&

# Setup ca-certificates (if any)
gecho "Setting up ca-certificates" &&
cd ../ca-certificates &&
for cert in $(ls); do
  echo "Adding $cert" &&
  sudo cp "$cert" "/usr/share/ca-certificates/$cert.crt" &&
  sudo dpkg-reconfigure -f noninteractive ca-certificates &&
  sudo update-ca-certificates
done &&
cd -

# Configure WiFi and VPN
### TODO: Ask for vpn user name, pass and configure the conection

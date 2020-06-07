#!/usr/bin/env bash
# Setup network and install certificates

source ./functions/utils.sh && no-root

# Install ca-certificates, VPN IKEv2, etc
gecho "Installing network tools"

PKGS=(
  inetutils-traceroute # displays the route taken by IP packets
  inetutils-telnet # interactive communication with another host
  ca-certificates # common CA certificates
  strongswan # IPsec VPN solution metapackage
  network-manager-strongswan # strongSwan plugin for network manager
  libcharon-extra-plugins # strongSwan charon library
  libstrongswan-extra-plugins # strongSwan utility and crypto library
  remmina # GTK+ remote desktop client
  whois # client for the whois directory service
  nmap # network exploration tool and security / port scanner
)
apt-install ${PKGS[@]}

# Setup ca-certificates (if any)
gecho "Setting up ca-certificates"
cd ca-certificates
for cert in $(ls); do
  echo "Adding $cert"
  sudo cp "$cert" "/usr/share/ca-certificates/$cert"
  sudo dpkg-reconfigure -f noninteractive ca-certificates
  sudo update-ca-certificates
done
cd -

# Configure VPN
### TODO: Ask for vpn user name, pass and configure the connection

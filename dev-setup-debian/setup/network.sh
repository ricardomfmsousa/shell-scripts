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

# Mount Google Drive on Linux
apt-install-ppa "alessandro-strada/ppa" "google-drive-ocamlfuse" &&

# Setup ca-certificates (if any)
gecho "Setting up ca-certificates" &&
cd ../ca-certificates &&
for cert in $(ls); do
  echo "Adding $cert" &&
  sudo cp "$cert" "/usr/local/share/ca-certificates/$cert" &&
  sudo update-ca-certificates
done &&
cd - &&

# Setup one gdrive account mounting it at startup
# (The authetication screen will be triggered after reboot)
gecho "Setting up gdrive auto-mount" &&
GDRIVE_FOLDER="$HOME/gdrive" &&
mkdir -p "$GDRIVE_FOLDER" &&
add-to-startup "gdrive" "sh -c \"google-drive-ocamlfuse $GDRIVE_FOLDER\""

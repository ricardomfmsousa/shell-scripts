#!/usr/bin/env bash
# Setup all databases and its GUIs

source ./functions/utils.sh && no-root

# Install DBeaver lastest - handle relational databases
download-install-deb 'https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb'

# Install MongoDB Compass - Official GUI for MongoDB
download-install-deb 'https://downloads.mongodb.com/compass/mongodb-compass_1.20.5_amd64.deb'

# Install mongodb from the official repo
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add - 
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt update
apt-install mongodb-org
# TODO: ask if it should autostart mongodb service
# sudo systemctl enable mongodb.service

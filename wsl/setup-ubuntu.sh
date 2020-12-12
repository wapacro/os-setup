#!/bin/bash

# Configuration
export USER='roman'
export PHPVERSION='8.0'
export NODEJSVERSION='14.x'
export PACKVERSION='0.15.1'

# Install packages
./ubuntu/00-packages.sh

# Setup Aliases
cp ./ubuntu/01-aliases.sh /etc/profile.d/01-aliases.sh

# Cleanup
apt upgrade --yes
apt autoremove --purge --yes
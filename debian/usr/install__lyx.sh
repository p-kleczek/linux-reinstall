#!/bin/bash

source config.cfg

# ============================================================================

# REF:  https://www.itzgeek.com/how-tos/linux/debian/simple-way-to-install-google-chrome-on-debian-9.html

# Download the Google signing key and install it.
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

# Set up Google Chrome repository.
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
# Update repository index.
sudo apt update

sudo apt install -y --fix-broken

# Install Google Chrome

simple_pkg_install google-chrome-stable

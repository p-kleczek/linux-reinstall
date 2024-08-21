#!/bin/bash

source config.cfg

# ============================================================================

# REF:  https://deb.avast.com/lin/doc/techdoc.pdf
# (2 Installation -- Debian/Ubuntu)

# 1. Add the Avast repository to the system repositories
echo "deb http://deb.avast.com/lin/repo debian-buster release" | sudo tee /etc/apt/sources.list.d/avast.list

# 2. Install Avast public key and update package manager state
# Download the Google signing key and install it.
wget -q -O - https://files.avast.com/files/resellers/linux/avast.gpg | sudo apt-key add -
# Update repository index.
sudo apt update

# 3. Install the avast package and optionally the avast-fss package.
simple_pkg_install avast
simple_pkg_install avast-fss

#!/bin/bash

source config.cfg

# ============================================================================

# = Sublime Text 3 =
# REF: https://wiki.debian.org/SublimeText
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
simple_pkg_install apt-transport-https
sudo apt update
simple_pkg_install sublime-text

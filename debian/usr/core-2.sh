#!/bin/bash

source config.cfg

# ============================================================================

#
# == Instalacja sterowników od NVIDIA  (cz. 2) ==
#

# Enable i386.
sudo dpkg --add-architecture i386
# Install both the non-free firmware and the NVIDIA driver packages needed.
simple_pkg_install firmware-linux
simple_pkg_install nvidia-settings
simple_pkg_install nvidia-xconfig
simple_pkg_install nvidia-driver
# Generate an Xorg configuration file.
sudo nvidia-xconfig

logwarn "A reboot is required before proceeding with the next script!"
# reboot


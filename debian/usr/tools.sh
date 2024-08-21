#!/bin/bash

source config.cfg

# ============================================================================

# The ifconfig command has been deprecated and thus missing by default on Debian Linux, starting from Debian stretch.
# The new and recommended alternative for examining a network configuration on Debian Linux is ip command.
# For example to use ip command to display a network configuration run the following:
# $ ip address
simple_pkg_install net-tools

# A general purpose utility, that reports detailed and brief information about multiple different hardware units such as cpu, memory, disk, usb controllers, network adapters etc. Lshw extracts the information from different /proc files.
simple_pkg_install lshw

# Hwinfo is another general purpose hardware probing utility that can report detailed and brief information about multiple different hardware components, and more than what lshw can report.
simple_pkg_install hwinfo

# TODO: opis
simple_pkg_install hardinfo

simple_pkg_install pydf

simple_pkg_install inxi

# Możliwość ustawienia kolejności bootowanie w GRUB-ie.
simple_pkg_install grub-customizer

# Tablica znaków
simple_pkg_install charmap.app

# == Konfiguracja ==

# First, grab the current version of the pci.ids file from the Internet:
update-pciids


# == Przydatne polecenia ==

# Lista kart wraz z producentami.
# lspci
# lspci -v
# lspci -v | less

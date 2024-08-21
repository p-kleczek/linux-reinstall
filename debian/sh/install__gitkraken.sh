#!/bin/bash

source config.cfg

# ============================================================================

# = GitKraken =

pkg='gitkraken'; program_name='GitKraken'
if ! is_pkg_installed $pkg ; then
    logmisc "Installing $program_name..."
    
    GITKRAKEN_DEB='gitkraken-amd64.deb'

    wget -O $GITKRAKEN_DEB https://release.gitkraken.com/linux/$GITKRAKEN_DEB
    sudo dpkg -i $GITKRAKEN_DEB
    sudo apt install -y --fix-broken
    sudo dpkg -i $GITKRAKEN_DEB

    simple_pkg_install libgnome-keyring-common
    simple_pkg_install libgnome-keyring-dev

    rm $GITKRAKEN_DEB

    verify_pkg_installation $pkg $program_name
else
    echoinf "$program_name already installed."
fi    

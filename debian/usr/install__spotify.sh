#!/bin/bash

source config.cfg

# ============================================================================

## = Spotify =

# Install Spotify
pkg='spotify-client'; program_name='Spotify'
if ! is_pkg_installed $pkg ; then
    logmisc "Installing $program_name..."

    # NB: You will need to install dirmngr if not already installed
    simple_pkg_install dirmngr

    # Add the Spotify repository signing key to be able to verify downloaded packages
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A87FF9DF48BF1C90
    # Add the Spotify repository
    echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
    # Update list of available packages
    sudo apt update
    # (if needed) install libssl, eg.:
    simple_pkg_install libssl1.1

    simple_pkg_install $pkg

    verify_pkg_installation $pkg $program_name
else
    echoinf "$program_name already installed."
fi

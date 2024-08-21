#!/bin/bash

source config.cfg

# ============================================================================

# In 2016, libgnome-keyring is specific to GNOME and is now deprecated (since January 2014, actually).
# Git 2.11+ (Q4 2016) will include a new credential helper using libsecret.

# Install libsecret and the development libraries.
simple_pkg_install gnome-keyring
simple_pkg_install libsecret-1-0
simple_pkg_install libsecret-1-dev

# Build the credential manager
CREDENTIAL_MANAGER_DIR='/usr/share/doc/git/contrib/credential/libsecret'
sudo cd "$CREDENTIAL_MANAGER_DIR" && sudo make

git config credential.helper "/usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret"

# https://davidwalsh.name/git-default-remote
git config --global push.default current

git config --global --unset user.name
git config --global --unset user.email

git config --global credential.helper 'cache --timeout=99999'

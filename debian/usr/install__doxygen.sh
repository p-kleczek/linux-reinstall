#!/bin/bash

source config.cfg

# ============================================================================

# = Doxygen =
pkg='doxygen'; program_name='Doxygen'
if ! is_pkg_installed $pkg ; then
    logmisc "Installing $program_name..."
    
    simple_pkg_install $pkg

    verify_pkg_installation $pkg $program_name
else
    echoinf "$program_name already installed."
fi

#!/bin/bash

source config.cfg

# ============================================================================

pkg='texlive'; program_name='TexLive'
if ! is_pkg_installed $pkg ; then
    logmisc "Installing $program_name..."
    
    simple_pkg_install $pkg

    verify_pkg_installation $pkg $program_name
else
    echoinf "$program_name already installed."
fi

pkg='texstudio'; program_name='TeXstudio'
if ! is_pkg_installed $pkg ; then
    logmisc "Installing $program_name..."
    
    simple_pkg_install $pkg

    verify_pkg_installation $pkg $program_name
else
    echoinf "$program_name already installed."
fi

simple_pkg_install xzdec

# Package GUI needs it...
# tlmgr --gui
simple_pkg_install perl-tk

# Initialize tlmgr
tlmgr init-usertree

# Instalacja stadardowych pakietów:
tlmgr install geometry psnfss latex babel xcolor enumitem multirow booktabs makecell threeparttable l3packages cprotect courier mdwtools filecontents mathtools amsfonts amsmath amscls was url hyperref graphics float caption tools graphbox titlesec pgf pgfplots tikzscale siunitx csquotes fp etoolbox listings preprint todonotes bigfoot xstring biblatex logreq

# Aktualizacja zainstalowanych pakietów:
tlmgr update --all

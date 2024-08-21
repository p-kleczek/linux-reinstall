#!/bin/bash

source config.cfg

# ============================================================================
#                       << INSTALACJA APLIKACJI >>
# ============================================================================


simple_pkg_install gedit
simple_pkg_install gparted


./install__sublime_text.sh

# = RedShift =
# (odpowiednik f.lux)
simple_pkg_install redshift
simple_pkg_install redshift-gtk

# PulseAudio #
simple_pkg_install pavucontrol

# KDirStat #
#  disk usage statistics viewer
simple_pkg_install k4dirstat


# = Git =
simple_pkg_install git-gui
simple_pkg_install gitg  # GUI (https://wiki.gnome.org/Apps/Gitg/)
./install__git_env.sh
./install__gitkraken.sh
./install__giteye__usr.sh

./install__spotify.sh


## = LLVM & clang  (testing) - do celów rozwoju oprogramowania =
## Stabilna wersja LLVM na 2019-01-09 to 3.8 ...
##LLVM_VERSION="7"
##DEBIAN_FRONTEND=noninteractive apt install -t testing llvm-$LLVM_VERSION clang-$LLVM_VERSION -y


./install__fiji.sh
simple_pkg_install inkscape

./install__doxygen.sh
./install__llvm.sh


# = Kompare =
# (nakładka graficzna na narzędzia do porównywania plików, np. diff)
simple_pkg_install kompare

./install__dropbox.sh

# ============================================================================
#       << INSTALACJA APLIKACJI WYMAGAJĄCYCH INTERAKCJI Z UŻYTKOWNIKIEM>>
# ============================================================================

logwarn 'Uncomment and execute manually!'

exit

./install__pycharm.sh
./install__clion.sh
./install__phpstorm.sh
./install__matlab.sh
./install__texlive_texstudio.sh


logwarn 'Install Anaconda (i.e. to get newest Python interpreter)!'

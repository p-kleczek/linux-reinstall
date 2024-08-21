#!/bin/bash

source config.cfg

# ============================================================================

#
# == Aktualizacja pakietów ==
#

# Zaktualizuj listę pakietów

if ! [ -e /etc/apt/sources.list ]; then
    # Restore the original (renamed) file.
    sudo mv /etc/apt/sources.list.original /etc/apt/sources.list
fi

if [ -e /etc/apt/sources.list ]; then
    # (Zakomentuj linijkę z wpisem zaczynającym się od deb cdrom: – w tym celu dodaj na początku znak “#”. W ten sposób unikniesz błędów w stylu: “Media change: please insert the disc labeled …”).
    logmisc 'Updating /etc/apt/sources.list ...'
    sudo sed -i 's/^deb cdrom:/# deb cdrom:/' /etc/apt/sources.list
    sudo sed -i 's/main$/main contrib non-free/' /etc/apt/sources.list
    sudo sed -i 's/main contrib$/main contrib non-free/' /etc/apt/sources.list
    
    # TODO: Wyrównaj etykiety.
    #sed -i 's/^deb (! )/deb     /' /etc/apt/sources.list
    # FIXME: perl /etc/apt/sources.list -e 's/^deb (! )/deb     /' out.txt

    
    loginfo '  [INFO] /etc/apt/sources.list updated' 
fi


# [!!!] REF: https://serverfault.com/a/382101

# Create the following files in /etc/apt/preferences.d:

sudo tee /etc/apt/preferences.d/stable.pref <<EOF
# 500 <= P < 990: causes a version to be installed unless there is a
# version available belonging to the target release or the installed
# version is more recent

Package: *
Pin: release a=stable
Pin-Priority: 900
EOF

sudo tee /etc/apt/preferences.d/testing.pref <<EOF
# 100 <= P < 500: causes a version to be installed unless there is a
# version available belonging to some other distribution or the installed
# version is more recent

Package: *
Pin: release a=testing
Pin-Priority: -1
EOF

sudo tee /etc/apt/preferences.d/unstable.pref <<EOF
# 0 < P < 100: causes a version to be installed only if there is no
# installed version of the package

Package: *
Pin: release a=unstable
Pin-Priority: -1
EOF

sudo tee /etc/apt/preferences.d/experimental.pref <<EOF
# 0 < P < 100: causes a version to be installed only if there is no
# installed version of the package

Package: *
Pin: release a=experimental
Pin-Priority: -1
EOF

sudo tee /etc/apt/preferences.d/stretch-backports.pref <<EOF
# 0 < P < 100: causes a version to be installed only if there is no
# installed version of the package

Package: *
Pin: release a=stretch-backports
Pin-Priority: -1
EOF

loginfo 'Preferences in /etc/apt/preferences.d created'


# Create a matching set for /etc/apt/sources.list.d

if ! [ -e /etc/apt/sources.list ]; then
    # Restore the original (renamed) file.
    sudo mv /etc/apt/sources.list.original /etc/apt/sources.list
fi

# REF:  https://wiki.debian.org/DebianTesting

# Usuń wszystkie istniejące listy użytkownika.
sudo rm /etc/apt/sources.list.d/*.list

fix_nonstable_lists () {
    REPO=$1
    LIST_FILE_T="/etc/apt/sources.list.d/$REPO.list"
    sudo cp /etc/apt/sources.list $LIST_FILE_T
    sudo sed -i "s/stretch/$REPO/g" $LIST_FILE_T
    # Remove or comment out your stable security updates line(s) (anything with security.debian.org in it).
    sudo sed -i 's/^.*security\.debian\.org.*$//' $LIST_FILE_T
    # Remove or comment out any other stable-specific lines, like *-backports or *-updates.
    sudo sed -i 's/^.*-updates.*$//' $LIST_FILE_T
    sudo sed -i 's/^.*-backports.*$//' $LIST_FILE_T
}

# stable.list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.d/stable.list

# testing.list
fix_nonstable_lists "testing"

# unstable.list
fix_nonstable_lists "unstable"

# experimental.list
fix_nonstable_lists "experimental"

# backports.list
fix_nonstable_lists "stretch-backports"

# Rename the (old) file /etc/apt/sources.list
sudo mv /etc/apt/sources.list /etc/apt/sources.list.original


# Ubicie poniższych pakietów jest wymagane do konfiguracji pakietu lib6
pkill screensaver
pkill xlockmore
loginfo 'screensaver and xlockmore killed'


# Uaktualnij repozytorium pakietów
sudo apt update -y
sudo apt upgrade -y
sudo apt full-upgrade -y
sudo apt autoremove -y
loginfo 'Package repo updated & upgraded'


# Zainstaluj pakiety niezbędne do działania innych pakietów
simple_pkg_install build-essential

# Zainstaluj przydatne narzędzia
simple_pkg_install rsync

#
# == Skonfiguruj [KDE5] ==
#

./configure__kde.sh

#
# == NumLock włączony na ekranie logowania (SDDM) ==
#

simple_pkg_install numlockx

sudo tee /etc/sddm.conf <<EOF
[General]
Numlock=on
EOF

#
# == Prawa dostępu do partycji ==
#

# Wykonaj poniższe polecenie dla każdej partycji:
# chown <user> -R <partition_path>
sudo chown "$USERNAME" -R /data1
sudo chown "$USERNAME" -R /data2
loginfo 'Rights to partitions updated'


#
# == Instalacja sterowników od NVIDIA  (cz. 1) ==
#

# Zainstaluj stabilną wersję LLVM i clang.
simple_pkg_install llvm
simple_pkg_install clang

loginfo 'LLVM installed (required to update nVidia driver)'

logwarn 'A reboot is required before proceeding with the next script!'
# reboot


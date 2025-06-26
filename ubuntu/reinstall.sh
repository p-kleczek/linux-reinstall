#! /bin/bash

# TODO:
# - wget should save files in ~./Downloads/installers dir (which should be cleaned upon successful installation)

DOWNLOADS=~/Downloads

# DISTRO_CODENAME=jammy   # 22.04
DISTRO_CODENAME=noble     # 24.04


# [PRE] Install system tools
sudo apt install -y wget
sudo apt install -y snapd
sudo apt install -y software-properties-common

# [TOOLS]
sudo apt install -y libtiff6  # 24.04+
# FIXME: libtiff5 - 22.04-
#sudo apt install -y libtiff5
sudo apt install -y kde-cli-tools

sudo apt install -y plocate
sudo apt install -y font-manager

# ComposeKey
sudo apt install -y gnome-tweaks

# heif-convert
sudo apt install -y libheif-examples


# =========================================================

# [P4] GParted
sudo apt install -y gparted

# [C5] GRUB Customizer
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo apt update
sudo apt install -y grub-customizer
# FIXME: Configure.

# [C4] Wykonuj poniższy ciąg poleceń do momentu, aż wszystkie pakiety zostaną zaktualizowane:
sudo apt update && sudo apt upgrade
sudo apt full-upgrade
sudo apt autoremove
# FIXME: Repeat until no more changes.

# [C6.1] dconf-editor
sudo apt update
sudo apt install -y dconf-editor

# [C7] Minimalizacja aplikacji po kliknięciu na ikonie w Launcherze
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

# [C8] Pasek zadań: Dash to Panel
sudo apt install -y gnome-shell-extension-manager gnome-shell-extensions
# FIXME: Configure.

# [C10] Dolphin
sudo apt install -y qml-module-org-kde-kcm
sudo apt install -y konsole
sudo apt install -y dolphin

# [C10.3] Nautilus Terminal
# FIXME: Only up to Ubuntu 22.04
#sudo add-apt-repository ppa:flozz/nautilus-terminal
#sudo apt update
#sudo apt install -y nautilus-terminal

# [C11] Czcionki Microsoft
sudo add-apt-repository -y multiverse
sudo apt update
sudo apt install -y ttf-mscorefonts-installer
# (manual: EULA)

# sudo apt install -y gnome-shell-extension-ubuntu-docket

# =========================================================

# Games
sudo snap install gnome-mahjongg
sudo snap install gnome-mines
sudo snap install gnome-sudoku

# =========================================================


# [P1] ClamAV
sudo apt install -y clamav clamav-daemon
# GUI
sudo apt install -y clamtk

# Check installation:
clamscan --version


# [P2] LibreOffice
# Pakiety językowe.
sudo apt install -y libreoffice
sudo apt install -y libreoffice-l10n-pl
# Repo pod kątem aktualizacji.
sudo add-apt-repository -y ppa:libreoffice/ppa

# [P3] gEdit
sudo apt install -y gedit

# [P5] Mozilla Firefox
sudo snap install firefox

# [P6] Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

# [P7.2] Sublime Text 3/4
# Install the GPG key.
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
# Use stable channel.
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
# Install.
sudo apt update
sudo apt install -y sublime-text

# [P8] RedShift
# FIXME: No longer needed in Ubuntu 22.04+
#sudo apt install -y redshift redshift-gtk geoclue-2.0
#sudo apt install geoclue-2.0

# [P9] PulseAudio
sudo apt install -y pavucontrol

# [P10] Git
sudo apt install -y git

# [P11] TexLive
# (manual)

# tlmgr init-usertree
# Teraz, w celu instalacji pakietów, uruchom skrypt: install_texlive_packages.sh

# [P12] PyCharm IDE
sudo snap install pycharm-community --classic

# [P13] C/C++ toolchains & tools
sudo apt install -y build-essential
sudo apt install -y cmake gcc g++ clang

# [P15.3] Miniconda / Anaconda - pakiety
# (do uruchomienia dopiero po instalacji głównego programu)
# conda install -y numpy
# conda install -y pandas
# conda install -c -y conda-forge scikit-learn
# conda install -c -y conda-forge matplotlib

# [P15.4] Jupyter Lab
# (do uruchomienia dopiero po instalacji głównego programu)
# conda install -y jupyterlab
# jupyter notebook --generate-config

# [P16] Kompare
sudo apt install -y kompare

# [P17] QDirStat
sudo apt install -y qdirstat

# [P18] FileZilla
sudo apt install -y filezilla

# [P19] Audacity
sudo apt install -y audacity

# [P20] tree
sudo apt install -y tree

# [P21] 7-Zip
sudo apt install -y p7zip-full p7zip-rar
# GUI
sudo snap install -y p7zip-desktop

# [P22] AnyDesk
# (manual)

# [P23] Avidemux
sudo apt install -y software-properties-common apt-transport-https
sudo add-apt-repository -y ppa:xtradeb/apps
sudo apt update
sudo apt install -y avidemux*
sudo systemctl daemon-reload

# [P24] Calibre
sudo apt install -y calibre

# [P25] Code::Blocks
sudo apt install -y codeblocks
sudo apt install -y codeblocks-contrib

# [P26] Dia
sudo apt install -y dia

# [P27] CUPS
sudo apt install -y printer-driver-cups-pdf
sudo systemctl daemon-reload

# [P28] CMake
sudo apt install -y cmake

# [P29] Ghidra
# (manual)

# [P30] GIMP
sudo apt install -y gimp

# [P31] Inkscape

# Install most recent version
sudo add-apt-repository -y universe
sudo add-apt-repository -y ppa:inkscape.dev/stable
sudo apt update
sudo apt install -y inkscape

# FIXME: v0.92
#sudo add-apt-repository ppa:inkscape.dev/stable-0.92
#sudo apt update
#sudo apt install inkscape

# Reinstall:
# rm -r ~/.config/inkscape


# [P32] IrfanView
sudo snap install irfanview

# [P34] Wine
# FIXME: If `dpkg --print-foreign-architectures` returns nothing - execute the following...
#  On 64-bit systems, applications that support “32-bit” architecture does not work properly. So, if you are working on a “64-bit” system, then utilize the following command to enable “32-bit” Architecture.
sudo dpkg --add-architecture i386
# FIXME: Make sure `dpkg --print-foreign-architectures` returns a string containing "i386"

# # Add “Wine” repository to the system.
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

# Download and add the WineHQ repository key.
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

# Download the WineHQ sources file.
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/${DISTRO_CODENAME}/winehq-${DISTRO_CODENAME}.sources

  # Ubuntu 22.04
  # wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
  # sudo mv winehq-jammy.sources /etc/apt/sources.list.d/

# Install.
sudo apt update
sudo apt install -y --install-recommends winehq-stable
# FIXME: If unavailable, install winehq-devel
# sudo apt install -y --install-recommends winehq-devel

# FIXME: Verify the installation succeeded
wine --version

# Configure for Win64 architecture; programs will be installed under WINEPREFIX location.
export WINEARCH=win64
export WINEPREFIX=~/.wine64
# FIXME: Ten krok wymaga ręcznej interakcji...
winecfg

# Winetricks
sudo apt install -y cabextract unzip p7zip wget zenity

# [P33] JabRef
sudo snap install jabref

# [P35] Minimal ADB and Fastboot
sudo apt install -y android-tools-adb android-tools-fastboot

# FIXME: Verify...
adb version

# [P36] Mp3Gain
sudo snap install mp3gain easymp3gain

# [P37] Mp3splt
sudo apt install -y mp3splt-gtk

# [P38] Notepad++
sudo snap install notepad-plus-plus

# [P39] OBS Studio
sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo apt update
sudo apt install -y ffmpeg obs-studio

# [P40] PDFsam
# (manual)

# [P41] PuTTY
sudo add-apt-repository -y universe
sudo apt update
sudo apt install -y putty

# [P42] pympress
sudo apt install -y pympress

# [P43] Signal
# 1. Install our official public software signing key
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
# 2. Add our repository to your list of repositories
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
# 3. Update your package database and install signal
sudo apt update
sudo apt install -y signal-desktop

# [P44] Skype
sudo snap install skype --classic

# [P45] qps
sudo apt install -y qps

# [P46] Spotify
sudo snap install spotify

# [P47] Perl
sudo apt install -y perl

# [P48] TexStudio
sudo apt install -y texstudio

# [P49] Viber
# Install dependencies.
sudo apt install -y gstreamer1.0-pulseaudio
wget -P ${DOWNLOADS} https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
sudo dpkg -i ${DOWNLOADS}/viber.deb

# [P50] VLC
sudo snap install vlc

# [P51] Weka
# (opt)

# [P52] WhatsApp
sudo snap install whatsapp-for-linux

# [P53] DjView
sudo apt install -y djview

# [P54] Meld
sudo apt install -y meld

# [P55] Xournal
sudo apt install -y xournalpp

# [P56] YakYak
sudo snap install yakyak

# [P57] ufw
sudo apt install -y gufw
sudo ufw enable

# [P58] qBittorrent
sudo apt install -y qbittorrent

# [P59] Fiji / ImageJ
# (manual)

# [P60] FreeCAD
sudo snap install freecad

# [P61] ProtonVPN
# (manual)

# [P62] ImageMagick
sudo apt install -y imagemagick

# [P63] OpenJDK
sudo apt install -y default-jre

# [P64] Graphviz
sudo apt install -y graphviz

# [P65] gv
sudo apt install -y gv

# [P66] Ghostscript
sudo apt install -y ghostscript

# [P67] GNOME Online Accounts
sudo apt install -y gnome-online-accounts

# [P68] Hugin
sudo apt install -y hugin

# [P69] AcetoneISO
sudo apt install -y acetoneiso

# [P70] TestDisk
sudo apt install -y testdisk

# [P71] SimpleScreenRecorder
sudo apt install -y simplescreenrecorder

# [P73] NetBeans
# ccls C/C++/ObjC Language Server
# https://snapcraft.io/install/ccls/ubuntu
sudo snap install ccls --classic
sudo snap install netbeans --classic

# [P74] Visual Studio Code
sudo snap install --classic code

# Download DEB: https://code.visualstudio.com/docs/setup/linux
# sudo dpkg -i <file>.deb

# Installing the .deb package will automatically install the apt repository and signing key to enable auto-updating using the system's package manager. Alternatively, the repository and key can also be installed manually with the following script:
# sudo apt install -y wget gpg
# wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
# sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
# sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
# rm -f packages.microsoft.gpg

# Then update the package cache and install the package using:
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code # or code-insiders

# [P75] xChm Viewer
sudo apt install -y xchm

# [P76] Adobe Reader DC
sudo snap install acrordrdc

# [P77] Mate Utils
sudo apt install -y mate-utils

# [P78] Git Credential Manager
# (manual)

# [P79] distrobuilder
sudo snap install distrobuilder --classic

# [P80] VirtualBox

# Install prerequisites:
wget -P ${DOWNLOADS} http://archive.ubuntu.com/ubuntu/pool/main/libv/libvpx/libvpx7_1.12.0-1ubuntu2_amd64.deb
sudo apt install ${DOWNLOADS}/libvpx7_1.12.0-1ubuntu2_amd64.deb
#(Optional) You can also install libsdl-ttf2.0-0 with: sudo apt install libsdl-ttf2.0-0

# 1. Install VirtualBox's official public software signing key.
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor > virtualbox-keyring.gpg
cat virtualbox-keyring.gpg | sudo tee -a /usr/share/keyrings/virtualbox-keyring.gpg > /dev/null
# 2. Add the repository to the list of repositories.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/virtualbox-keyring.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib'| sudo tee -a /etc/apt/sources.list.d/virtualbox.list
# 3. Update the package database and install VirtualBox.
sudo apt update
sudo apt install -y virtualbox-7.0 virtualbox-ext-pack
# Rozszerzenia (dodatkowe funkcjonalności) dla VirtualBox.
sudo apt install -y virtualbox-ext-pack
# FIXME: Requires manual confirmation.
# (manual EULA confirmation)

#sudo usermod -aG vboxusers <your_linux_username>
sudo usermod -aG vboxusers pawel

# [P81] Shutter
sudo apt install -y shutter

# [P82] PostgreSQL & pgAdmin
# FIXME: Uncomment.
#sudo apt install postgresql postgresql-contrib

# FIXME: Uncomment.
## Add the GPG Key of pgAdmin:
##   Source : https://gist.github.com/dweldon/cfe080d7cc189df3217dcc1c15ae96db
#wget https://www.pgadmin.org/static/packages_pgadmin_org.pub
#gpg --no-default-keyring --keyring ./temp-keyring.gpg --import packages_pgadmin_org.pub
#gpg_file="pgadmin4.gpg"
#gpg --no-default-keyring --keyring ./temp-keyring.gpg --export --output "${gpg_file}"
#rm temp-keyring.*
#rm packages_pgadmin_org.pub
#sudo chown root:root "${gpg_file}"
#sudo mv "${gpg_file}" /etc/apt/keyrings/

# FIXME: Uncomment.
## Add the pgAdmin Repository:
#echo "deb [signed-by=/etc/apt/keyrings/${gpg_file}] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" | sudo tee /etc/apt/sources.list.d/pgadmin4.list
#sudo apt-get update
## Install pgAdmin (choose one of: pgadmin4 | pgadmin4-desktop | pgadmin4-web):
#sudo apt-get install -y pgadmin4-desktop

# [P83] Telegram
sudo snap install telegram-desktop
# FIXME: Below - Ubuntu 22.04-
#sudo apt install -y telegram-desktop

# [P84] Blender
sudo apt install -y blender

# [P85] Okular
sudo apt install -y okular

# [P86] Double Commander (GTK = for Ubuntu)
sudo apt install -y doublecmd-gtk

# [P87] GPaste
sudo apt install -y gpaste-2
# FIXME: Below - Ubuntu 22.04-
#sudo apt install -y gpaste

# [P88] KDirStat
sudo apt install -y k4dirstat

# [P89] GNOME Remote Desktop
sudo apt install -y gnome-remote-desktop

# [P90] MinGW-w64
sudo apt install -y mingw-w64

# [P91] EasyTAG
sudo apt install -y easytag

# [P92] Google Earth Pro
# Install Google Earth repository key (as trusted one).
sudo wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/google-earth.gpg >/dev/null
# Add the Google Earth apt repository into your system
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-earth.gpg] https://dl.google.com/linux/earth/deb/ stable main" > /etc/apt/sources.list.d/google-earth.list'
sudo apt update
sudo apt install -y google-earth-pro-stable

# [P93] Gramps
sudo apt install -y gramps

# [P94] Grass GIS
#sudo apt install -y grass

# [P95] ImageJ
sudo apt install -y imagej

# [P96] LibreCAD
sudo apt install -y librecad

# [P97] QGIS
sudo apt install -y gnupg software-properties-common
# Install QGIS repository key (as trusted one).
sudo wget -qO /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg
# Add the Google Earth apt repository into your system

# FIXME: predefined distro name
sudo tee -a /etc/apt/sources.list.d/qgis.sources > /dev/null <<EOT
Types: deb deb-src
URIs: https://qgis.org/debian
Suites: ${DISTRO_CODENAME}
Architectures: amd64
Components: main
Signed-By: /etc/apt/keyrings/qgis-archive-keyring.gpg
EOT

sudo apt update
sudo apt install -y qgis qgis-plugin-grass

# [P98] Simple Scan
sudo snap install simple-scan

# [P99] CUPS GUI
sudo apt install -y system-config-printer

# [P100] MeGit
# (download-only)

# [P101] TIFFSplit
sudo apt install -y libtiff-tools

# [P102] TeamViewer
wget -P ${DOWNLOADS} https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo apt update
sudo apt install ${DOWNLOADS}/teamviewer_amd64.deb

# [P103] PWN-EN
# (install in VirtualBox)

# [P104] PWN-RU
# (install in VirtualBox)

# [P105] Apache
sudo apt install -y apache2

# [P106] PHP
sudo apt install -y php8.3

# [P107] yED
# (manual)

sudo bash register_graphml_mime_type.sh
echo "You still need to associate application/graphml with yEd!"

# [P108] JOSM
sudo snap install josm

# [P109] GhostWriter
sudo apt install ghostwriter


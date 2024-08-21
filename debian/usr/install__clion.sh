#!/bin/bash

source config.cfg

# ============================================================================

# = CLion IDE =

program_name='CLion IDE'

APP_VERSION='CLion-2018.3.3'


APP_DIR="$(echo "$APP_VERSION" | tr '[:upper:]' '[:lower:]')"

if [ ! -d "/opt/${APP_DIR}" ]; then
    APP_TAR="$APP_VERSION.tar.gz"

    # Download PyCharm
    wget -O $APP_TAR "https://download.jetbrains.com/cpp/$APP_VERSION.tar.gz"

    # Unpack the pycharm-*.tar.gz file to a different folder
    # The recommended installation location according to the filesystem hierarchy standard (FHS) is /opt.
    sudo tar xfz $APP_TAR -C /opt/

    rm $APP_TAR

    # Wyświetl lokalizację wszystkich zainstalowanych wersji kompilatora clang.
    dpkg-query --showformat='${Package}\n' --show | grep '^clang-' | while read pkg; do
        echo $( whereis "$pkg" )
    done

    sh "/opt/${APP_DIR}/bin/clion.sh"


    echoinf "$program_name successfully installed."
else
    echoinf "$program_name already installed."
fi

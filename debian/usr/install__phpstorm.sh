#!/bin/bash

source config.cfg

# ============================================================================

# = PhpStorm IDE =

program_name='PhpStorm IDE'

APP_NAME='PhpStorm'
APP_VERSION='2018.3.3'

APP_FULLNAME="$APP_NAME-$APP_VERSION"
APP_NAME_LOWER="$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]')"


# Przeglądnij wszystkie foldery `/opt/PhpStorm-*/` i zobacz, czy plik
# `product-info.json` w jednym z nich zawiera odpowiedni wpis "version".

IS_APP_INSTALLED=0

for dir in /opt/PhpStorm-*/ ; do
    dir=${dir%*/}  # remove the trailing "/"
    if sudo grep -q $APP_VERSION "$dir/product-info.json" --no-messages ; then
        IS_APP_INSTALLED=1
        break
    fi
done

if [ $IS_APP_INSTALLED -eq 0 ] ; then
    APP_TAR="${APP_FULLNAME}.tar.gz"

    TEMP_DIR='app_temp'

    # Download PyCharm
    wget -O $APP_TAR "https://download.jetbrains.com/webide/${APP_TAR}"

    # Unpack the pycharm-*.tar.gz file to a different folder
    # The recommended installation location according to the filesystem hierarchy standard (FHS) is /opt.
    ##sudo tar xfz $APP_TAR -C /opt/
    mkdir -p $TEMP_DIR
    tar xfz $APP_TAR -C $TEMP_DIR

    APP_DIR="$(dir app_temp)"

    sudo mv "${TEMP_DIR}/${APP_DIR}" /opt/

    rm $APP_TAR

    sh "/opt/${APP_DIR}/bin/${APP_NAME_LOWER}.sh"


    echoinf "$program_name successfully installed."
else
    echoinf "$program_name already installed."
fi

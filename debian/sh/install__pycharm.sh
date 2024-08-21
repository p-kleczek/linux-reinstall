#!/bin/bash

source config.cfg

# ============================================================================


# = PyCharm IDE =
# https://www.jetbrains.com/help/pycharm/install-and-set-up-pycharm.html

program_name='PyCharm IDE'


APP_VERSION='pycharm-community-2018.3.3'

if [ ! -d "/opt/${APP_VERSION}" ]; then
    APP_TAR="${APP_VERSION}.tar.gz"

    # Download PyCharm
    wget -O $APP_TAR "https://download.jetbrains.com/python/${APP_TAR}"

    # Unpack the pycharm-*.tar.gz file to a different folder
    # The recommended installation location according to the filesystem hierarchy standard (FHS) is /opt.
    sudo tar xfz $APP_TAR -C /opt/

    rm $APP_TAR

    sh "/opt/${APP_VERSION}/bin/pycharm.sh"


    echoinf "$program_name successfully installed."
else
    echoinf "$program_name already installed."
fi

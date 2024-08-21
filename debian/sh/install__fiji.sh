#!/bin/bash

source config.cfg

# ============================================================================

# = Fiji / ImageJ =

program_name='Fiji'

FIJI_ZIP='fiji-linux64.zip'
FIJI_PATH="$APPS_DIR/Fiji.app/"

if [ ! -d "$FIJI_PATH" ]; then
	wget -O $FIJI_ZIP "https://downloads.imagej.net/fiji/latest/fiji-linux64.zip"
	mkdir -p $FIJI_PATH
	unzip $FIJI_ZIP -d $FIJI_PATH
	rm $FIJI_ZIP

    echoinf "$program_name successfully installed."
else
    echoinf "$program_name already installed."
fi

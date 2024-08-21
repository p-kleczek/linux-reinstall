#!/bin/bash

source config.cfg

# ============================================================================

# = Fiji / ImageJ =

program_name='Fiji'

FIJI_ZIP='fiji-linux64.zip'

if [ ! -d "$FIJI_PATH" ]; then
	wget -O $FIJI_ZIP "https://downloads.imagej.net/fiji/latest/fiji-linux64.zip"
	unzip -o $FIJI_ZIP -d "${APPS_DIR}"
	rm $FIJI_ZIP

    echoinf "${program_name} successfully installed."
else
    echoinf "${program_name} already installed."
fi

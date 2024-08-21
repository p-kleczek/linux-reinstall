#!/bin/bash

source config.cfg

# ============================================================================

# == GitEye ==

# REF:  https://www.collab.net/products/giteye

ZIP_FILE='GitEye-2.2.0-linux.x86_64.zip'
wget -O "$ZIP_FILE" "https://www.collab.net/sites/default/files/downloads/${ZIP_FILE}"

GITEYE_PATH="$APPS_DIR/GitEye/"
mkdir -p $GITEYE_PATH
unzip $ZIP_FILE -d $GITEYE_PATH
rm $ZIP_FILE


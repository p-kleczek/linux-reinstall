#!/bin/bash

source config.cfg

# ============================================================================

# == Dolphin - dodanie odpowiednich wpisów w polu "Places" ==

USERPLACES_FILENAME='user-places.xbel'
USERPLACES_FILE="$HOME/.local/share/$USERPLACES_FILENAME"

# sudo chown $USERNAME:$USERNAME "$USERPLACES_FILE"

# Utwórz kopię zapasową pliku.
create_bak_dir
cp "$USERPLACES_FILE" "$REINSTALL_BAK_DIR/$USERPLACES_FILENAME"

python3 "$REINSTALL_DIR/user-places_updater.py" "$USERNAME" "$REINSTALL_BAK_DIR" "$REINSTALL_DIR"
cp "$REINSTALL_DIR/$USERPLACES_FILENAME" "$USERPLACES_FILE"

rm "$REINSTALL_DIR/$USERPLACES_FILENAME"

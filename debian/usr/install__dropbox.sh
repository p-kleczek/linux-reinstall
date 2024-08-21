#!/bin/bash

source config.cfg

# ============================================================================

# = Dropbox =

DROPBOX_DIR="$HOME/.dropbox-dist"

if ! [ -d "$DROPBOX_DIR" ]; then
	cd "$HOME" && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
fi

simple_pkg_install python-gpgme

# Uruchamiaj przy logowaniu.
DROPBOX_DAEMON_SCRIPT="${HOME}/.config/autostart-scripts/dropbox.sh"
cat > "$DROPBOX_DAEMON_SCRIPT" <<EOF
~/.dropbox-dist/dropboxd
EOF
chmod 755 "$DROPBOX_DAEMON_SCRIPT"

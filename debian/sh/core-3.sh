#!/bin/bash

source config.cfg

# ============================================================================

# == Lokalizacja ==

LOCALE_PL='pl_PL.UTF-8 UTF-8'
if sudo grep -q "# $LOCALE_PL" /etc/locale.gen; then
    # Aby umożliwić wygenerowanie dodatkowych ustawień, odkomentuj odpowiednie wpisy w pliku /etc/locale.gen
    sudo sed -i "s/^# $LOCALE_PL/$LOCALE_PL/" /etc/locale.gen
    # Wygeneruj nowe ustawienia.
    locale-gen
else
    loginfo 'Locales already configured.'
fi


# == Dodawanie folderów ==

create_dir "$DOCS/Projects"
create_dir "$DOCS/AGH"


# ====

./install__google_chrome.sh

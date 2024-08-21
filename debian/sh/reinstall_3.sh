#!/bin/bash

# << SNIPPETS >>
#
# printf "str" >> $FILE
# echo "str" >> $FILE
#
# echo '  [DEBUG] Exited!'; exit 
#

echo
echo '  [!!!] Make sure you are on the `su` account... ($ sudo su)'
echo

# ============================================================================

# == Lokalizacja ==

LOCALE_PL='pl_PL.UTF-8 UTF-8'
if grep -q "# $LOCALE_PL" /etc/locale.gen; then
    # Aby umożliwić wygenerowanie dodatkowych ustawień, odkomentuj odpowiednie wpisy w pliku /etc/locale.gen
    sed -i "s/^# $LOCALE_PL/$LOCALE_PL/" /etc/locale.gen
    # Wygeneruj nowe ustawienia.
    locale-gen
else
    printf '\n  [INFO] Locales already configured.\n\n'
fi


# == Dodawanie folderów ==

create_dir_as_user "$HOME/Projects"
create_dir_as_user "$HOME/AGH"


# ====

./install__google_chrome.sh

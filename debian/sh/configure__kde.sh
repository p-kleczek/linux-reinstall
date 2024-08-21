#!/bin/bash

source config.cfg

# ============================================================================
#                             KONFIGURACJA dla KDE5
# ============================================================================

#
# == Blokowania ekranu -- wyłączone ==
#

KDE_SCREENSAVER_FILE="$HOME/.config/kscreenlockerrc"

set_property $KDE_SCREENSAVER_FILE 'Daemon' 'Autolock' 'false'
if [[ $? -eq 1 ]]; then
    echoinf 'Screen lock -- disabled.'
else
    echoinf 'Screen lock -- nothing to change'
fi

#
# == Otwieranie folderów -- podwójnym kliknięciem (nie pojedynczym) ==
#

KDE_GLOBALS_FILE="$HOME/.config/kdeglobals"

set_property $KDE_GLOBALS_FILE 'KDE' 'SingleClick' 'false'
if [[ $? -eq 1 ]]; then
    echoinf 'KDE "open with single click" -- changed to double click.'
else
    echoinf 'KDE "open with single click" -- nothing to change.'
fi

#
# == Format daty i godziny na pasku zadań -- 24-godz. ==
#

PLASMA_LOCALE_FILE="$HOME/.config/plasma-localerc"

set_property $PLASMA_LOCALE_FILE 'Formats' 'LC_TIME' 'pl_PL.UTF-8' ||
set_property $PLASMA_LOCALE_FILE 'Formats' 'useDetailed' 'true'
if [[ $? -eq 1 ]]; then
    echoinf 'Time locale -- set.'
else
    echoinf 'Time locale -- nothing to change.'
fi

#
# == Wyświetlanie daty na pasku zadań -- włączone==
#

PLASMA_DESKTOP_FILE="$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"

set_property $PLASMA_DESKTOP_FILE '[Containments][3][Applets][9][Configuration][Appearance]' 'showDate' 'true'
if [[ $? -eq 1 ]]; then
    echoinf 'Display date on taskbar -- set.'
else
    echoinf 'Display date on taskbar -- nothing to change.'
fi


#
# == Wysokość paska zadań ==
#

PLASMA_SHELL_FILE="$HOME/.config/plasmashellrc"

echowarn 'Check screen width before changing taskbar height!' 

set_property $PLASMA_SHELL_FILE '[PlasmaViews][Panel 3][Horizontal2560]' 'thickness' '60'
if [[ $? -eq 1 ]]; then
    echoinf 'Taskbar height -- set.'
else
    echoinf 'Taskbar height -- nothing to change.'
fi

#
# == Grupowanie zadań -- wyłączone ==
#

PLASMA_DESKTOP_FILE="$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"

set_property $PLASMA_DESKTOP_FILE '[Containments][3][Applets][6][Configuration][General]' 'groupingStrategy' '0'
if [[ $? -eq 1 ]]; then
    echoinf 'Task groupping -- disabled.'
else
    echoinf 'Task groupping -- nothing to change.'
fi

#
# == NumLock przy starcie Plasma -- wyłączony ==
#

KEYBOARD_HARDWARE_FILE="$HOME/.config/kcminputrc"

if ! [ -e "$KEYBOARD_HARDWARE_FILE" ]; then
    cat > "$KEYBOARD_HARDWARE_FILE" <<EOF
[Keyboard]
KeyboardRepeating=0
NumLock=0
RepeatDelay=600
RepeatRate=25
EOF
    logmisc "'$KEYBOARD_HARDWARE_FILE' file created."
fi

set_property $KEYBOARD_HARDWARE_FILE '[Keyboard]' 'NumLock' '0'
if [[ $? -eq 1 ]]; then
    echoinf 'NumLock on Plasma startup -- enabled.'
else
    echoinf 'NumLock on Plasma startup -- nothing to change.'
fi

#
# == Symbol € jako Alt+5 oraz kropka dziesiętna na klawiaturze numerycznej -- wyłączone ==
#

KEYBOARD_ADVANCED_FILE="$HOME/.config/kxkbrc"

if ! [ -e "$KEYBOARD_ADVANCED_FILE" ]; then
    cat > "$KEYBOARD_ADVANCED_FILE" <<EOF
[Layout]
DisplayNames=
LayoutList=
LayoutLoopCount=-1
Model=pc101
Options=eurosign:5,kpdl:dotoss
ResetOldOptions=true
ShowFlag=false
ShowLabel=true
ShowLayoutIndicator=true
ShowSingle=false
SwitchMode=Global
Use=false
EOF
    logmisc "'$KEYBOARD_ADVANCED_FILE' file created."
fi

# FIXME: pozostawić istniejące opcje (?)
set_property $KEYBOARD_ADVANCED_FILE '[Layout]' 'Options' 'eurosign:5,kpdl:dotoss'
if [[ $? -eq 1 ]]; then
    echoinf 'Advanced keyboard options -- set.'
else
    echoinf 'Advanced keyboard options -- nothing to change.'
fi

#
# == Globalne skróty klawiaturowe ==
#

GLOBAL_KEYBOARD_SHORTCUTS_FILE="$HOME/.config/kglobalshortcutsrc"

# FIXME: pozostawić istniejące opcje (?)
set_property $GLOBAL_KEYBOARD_SHORTCUTS_FILE '[ksmserver]' 'Lock Session' 'Meta+L\tScreensaver,Ctrl+Alt+L\tScreensaver,Lock Session' ||
set_property $GLOBAL_KEYBOARD_SHORTCUTS_FILE '[kwin]' 'MoveZoomLeft' ',Meta+Left,Move Zoomed Area to Left' ||
set_property $GLOBAL_KEYBOARD_SHORTCUTS_FILE '[kwin]' 'MoveZoomRight' ',Meta+Right,Move Zoomed Area to Right' ||
set_property $GLOBAL_KEYBOARD_SHORTCUTS_FILE '[kwin]' 'MoveZoomUp' ',Meta+Up,Move Zoomed Area Upwards' ||
set_property $GLOBAL_KEYBOARD_SHORTCUTS_FILE '[kwin]' 'Show Desktop' 'Meta+D,none,Show Desktop' ||
set_property $GLOBAL_KEYBOARD_SHORTCUTS_FILE '[kwin]' 'Window Maximize' 'Meta+Up,none,Maximize Window' ||
set_property $GLOBAL_KEYBOARD_SHORTCUTS_FILE '[kwin]' 'Window Quick Tile Left' 'Meta+Left,none,Quick Tile Window to the Left' ||
set_property $GLOBAL_KEYBOARD_SHORTCUTS_FILE '[kwin]' 'Window Quick Tile Right' 'Meta+Right,none,Quick Tile Window to the Right'

if [[ $? -eq 1 ]]; then
    echoinf 'Global keyboard shortcuts -- set.'
else
    echoinf 'Global keyboard shortcuts -- nothing to change.'
fi

#
# == Grupowanie zadań -- wyłączone ==
#

KWIN_FILE="$HOME/.config/kwinrc"

set_property $KWIN_FILE '[Windows]' 'ActiveMouseScreen' 'true'
if [[ $? -eq 1 ]]; then
    echoinf 'Active screen follows mouse -- enabled.'
else
    echoinf 'Active screen follows mouse -- nothing to change.'
fi

#
# == Własne skróty klawiaturowe ==
#

./configure__kde__custom_shortcuts.sh

#
# == Oszczędzanie energii monitora -- wyłączone ==
#

POWER_MANAGEMENT_FILE="$HOME/.config/powermanagementprofilesrc"

remove_property_group $POWER_MANAGEMENT_FILE '[AC][DPMSControl]'
if [[ $? -eq 1 ]]; then
    echoinf 'Screen Energy Saving -- disabled.'
else
    echoinf 'Screen Energy Saving -- nothing to change.'
fi

#
# == Dolphin -- domyślny widok (+ terminal) ==
#

DOLPHIN_FILE="$HOME/.config/dolphinrc"

set_property $DOLPHIN_FILE '[MainWindow]' 'State' 'AAAA/wAAAAD9AAAAAwAAAAAAAAC4AAACW/wCAAAAAvsAAAAWAGYAbwBsAGQAZQByAHMARABvAGMAawAAAAAA/////wAAAAoBAAAD+wAAABQAcABsAGEAYwBlAHMARABvAGMAawEAAAAmAAACWwAAAFABAAADAAAAAQAAAAAAAAAA/AIAAAAB+wAAABAAaQBuAGYAbwBEAG8AYwBrAAAAAAD/////AAAACgEAAAMAAAADAAAD3gAAAL78AQAAAAH7AAAAGAB0AGUAcgBtAGkAbgBhAGwARABvAGMAawEAAAAAAAAD3gAAAAoBAAADAAADJQAAAlsAAAAEAAAABAAAAAgAAAAI/AAAAAEAAAACAAAAAQAAABYAbQBhAGkAbgBUAG8AbwBsAEIAYQByAQAAAAD/////AAAAAAAAAAA='
if [[ $? -eq 1 ]]; then
    echoinf 'New Dolphin defaults -- set.'
else
    echoinf 'New Dolphin defaults -- nothing to change.'
fi

#
# == Dolphin - dodanie odpowiednich wpisów w polu "Places" ==
#

./configure__kde__places.sh

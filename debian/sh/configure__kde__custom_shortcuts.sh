#!/bin/bash

source config.cfg

# ============================================================================

HOTKEY_FILE="$HOME/.config/khotkeysrc"

if ! grep -q 'Uuid={38edd80a-a222-4cd4-84d3-c2fdc728a3c6}' "$HOTKEY_FILE"; then

    # Wyznacz numer kolejnego wpisu grupy `Data`.
    COUNTER=1
    while grep -q "Data_$COUNTER" "$HOTKEY_FILE" ; do
        let COUNTER=COUNTER+1 

        # Avoid an endless loop.
        if [ $COUNTER -gt 10 ]; then
            break
        fi
    done

    logdebug Data block ID: $COUNTER
    set_property $HOTKEY_FILE '[Data]' 'DataCount' "$COUNTER"

    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}]" >> $HOTKEY_FILE
    echo "Comment=Comment" >> $HOTKEY_FILE
    echo "DataCount=2" >> $HOTKEY_FILE
    echo "Enabled=true" >> $HOTKEY_FILE
    echo "Name=Apps" >> $HOTKEY_FILE
    echo "SystemGroup=0" >> $HOTKEY_FILE
    echo "Type=ACTION_DATA_GROUP" >> $HOTKEY_FILE
    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}Conditions]" >> $HOTKEY_FILE
    echo "Comment=" >> $HOTKEY_FILE
    echo "ConditionsCount=0" >> $HOTKEY_FILE
    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}_1]" >> $HOTKEY_FILE
    echo "Comment=Comment" >> $HOTKEY_FILE
    echo "Enabled=true" >> $HOTKEY_FILE
    echo "Name=Terminal" >> $HOTKEY_FILE
    echo "Type=SIMPLE_ACTION_DATA" >> $HOTKEY_FILE
    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}_1Actions]" >> $HOTKEY_FILE
    echo "ActionsCount=1" >> $HOTKEY_FILE
    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}_1Actions0]" >> $HOTKEY_FILE
    echo "CommandURL=konsole" >> $HOTKEY_FILE
    echo "Type=COMMAND_URL" >> $HOTKEY_FILE
    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}_1Conditions]" >> $HOTKEY_FILE
    echo "Comment=" >> $HOTKEY_FILE
    echo "ConditionsCount=0" >> $HOTKEY_FILE
    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}_1Triggers]" >> $HOTKEY_FILE
    echo "Comment=Simple_action" >> $HOTKEY_FILE
    echo "TriggersCount=1" >> $HOTKEY_FILE
    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}_1Triggers0]" >> $HOTKEY_FILE
    echo "Key=Ctrl+Alt+T" >> $HOTKEY_FILE
    echo "Type=SHORTCUT" >> $HOTKEY_FILE
    echo "Uuid={38edd80a-a222-4cd4-84d3-c2fdc728a3c6}" >> $HOTKEY_FILE
    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}_2]" >> $HOTKEY_FILE
    echo "Comment=Comment" >> $HOTKEY_FILE
    echo "Enabled=true" >> $HOTKEY_FILE
    echo "Name=Dolphin" >> $HOTKEY_FILE
    echo "Type=SIMPLE_ACTION_DATA" >> $HOTKEY_FILE
    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}_2Actions]" >> $HOTKEY_FILE
    echo "ActionsCount=1" >> $HOTKEY_FILE
    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}_2Actions0]" >> $HOTKEY_FILE
    echo "CommandURL=dolphin" >> $HOTKEY_FILE
    echo "Type=COMMAND_URL" >> $HOTKEY_FILE
    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}_2Conditions]" >> $HOTKEY_FILE
    echo "Comment=" >> $HOTKEY_FILE
    echo "ConditionsCount=0" >> $HOTKEY_FILE
    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}_2Triggers]" >> $HOTKEY_FILE
    echo "Comment=Simple_action" >> $HOTKEY_FILE
    echo "TriggersCount=1" >> $HOTKEY_FILE
    echo "" >> $HOTKEY_FILE
    echo "[Data_${COUNTER}_2Triggers0]" >> $HOTKEY_FILE
    echo "Key=Meta+E" >> $HOTKEY_FILE
    echo "Type=SHORTCUT" >> $HOTKEY_FILE
    echo "Uuid={a4eafd0c-bbd6-4fef-bae5-accf6a717681}" >> $HOTKEY_FILE


    GLOBAL_KEYBOARD_SHORTCUTS_FILE="$HOME/.config/kglobalshortcutsrc"

    set_property $GLOBAL_KEYBOARD_SHORTCUTS_FILE '[khotkeys]' '_k_friendly_name' 'System Settings Module' ||
    set_property $GLOBAL_KEYBOARD_SHORTCUTS_FILE '[khotkeys]' '{38edd80a-a222-4cd4-84d3-c2fdc728a3c6}' 'Ctrl+Alt+T,none,Terminal' ||
    set_property $GLOBAL_KEYBOARD_SHORTCUTS_FILE '[khotkeys]' '{a4eafd0c-bbd6-4fef-bae5-accf6a717681}' 'Meta+E,none,Dolphin'

    echoinf 'Custom shortcuts -- set.'
else
    echoinf 'Custom shortcuts -- nothing to change.'
fi

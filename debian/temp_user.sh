#!/bin/bash

source config.cfg

# ============================================================================

# Ustaw wersję sterownika (nazwa archiwum ZIP - bez rozszerzenia).
DRIVER_VERSION='IT5PPDLinux_1100010000MU'
# Ustaw ścieżkę to pliku z archiwum.
PATH_TO_ZIP="$REINSTALL_DIR/apps_archives/${DRIVER_VERSION}.zip"


LANGUAGE='English'


# Rozpakuj pobrane archiwum ZIP do folderu tymczasowego.
TEMP_DIR="${PWD}/bizhub_temp"
mkdir -p "$TEMP_DIR"
#unzip "$PATH_TO_ZIP" -d "$TEMP_DIR"

# Umieść znajdujący się w archiwum folderze <wersja_językowa>/CUPS1.2 plik PPD o końcówce UX (np. KOC759UX.ppd) w folderze /usr/share/ppd/custom/1) i nadaj mu uprawnienia 644:
PPD_TEMP_DIR="${TEMP_DIR}/${DRIVER_VERSION}/${LANGUAGE}/CUPS1.2/"
PPD_FILENAME=$( ls "$PPD_TEMP_DIR" | grep 'UX.ppd' )
PPD_USR_DIR='/usr/share/ppd/custom/'
PPD_USR_FILE="${PPD_USR_DIR}/${PPD_FILENAME}"
sudo cp "${PPD_TEMP_DIR}/${PPD_FILENAME}" "$PPD_USR_DIR"
sudo chmod 644 "${PPD_USR_FILE}"  # chmod u=rw,go=r


# Dodaj w pliku PPD po wpisie '*% Linux Version' linijki, które spowodują wywołanie odpowiedniego filtra CUPS.
if ! grep -q 'cupsFilter' "${PPD_USR_FILE}"; then
	sudo sed -i 's/^\*% Linux Version/\*% Linux Version\n\n\*cupsFilter\: "application\/vnd\.cups-raw 0 minolta"\n\*cupsFilter\: "application\/vnd\.cups-command 0 commandtops"\n\*cupsFilter\: "application\/vnd\.cups-postscript 0 minolta"\n/' "${PPD_USR_FILE}"
fi

# Utwórz filtr CUPS o nazwie minolta w folderze /usr/lib/cups/filter/ o odpowiedniej zawartości...
# (Ten plik umożliwi wstrzykiwanie poleceń PJL na urządzenie wielofunkcyjne.)
CUPS_FILE='/usr/lib/cups/filter/minolta'
sudo touch "$CUPS_FILE"
sudo tee "$CUPS_FILE" > /dev/null <<'EOF'
#!/bin/bash
 
source /etc/cups/ppd/${PRINTER}.km
 
echo -en "\033%-12345X"
echo -en "@PJL JOB\015\012"
echo -en "@PJL SET KMUSERNAME = \"${ACCOUNT_NAME}\"\015\012"
echo -en "@PJL SET KMUSERKEY2 = \"${ACCOUNT_PASSWORD}\"\015\012"
echo -en "@PJL SET KMCOETYPE = ${ACCOUNT_COETYPE}\015\012"
echo -en "@PJL ENTER LANGUAGE = POSTSCRIPT\015\012"
 
cat -
 
echo -en "\004\033%-12345X\015\012@PJL EOJ\015\012"
echo -en "\033%-12345X"
EOF
# ...i nadaj mu uprawnienia do wykonywania.
sudo chmod +x "$CUPS_FILE"

# Uruchom ponownie usługę CUPS2.
sudo service cups restart

xdg-open 'http://localhost:631/admin/'


exit


# Wejdź do panelu administratora CUPS: http://localhost:631/admin/ (dane logowania: jak do użytkownika root)

# Kliknij w sekcji Printers przycisk Add Printer.

# Wybierz Other Network Printers → LPD/LPR Host or Printer i kliknij przycisk Continue.

# W polu Connection wpisz lpd://149.156.199.190/print i kliknij przycisk Continue.

# Nadaj drukarce wybraną nazwę (np. Konica-Minolta-C258) i kliknij przycisk Continue.

# W sekcji Or Provide a PPD File kliknij przycisk Choose File, wybierz plik /usr/share/ppd/custom/KOC759UX.ppd i naciśnij przycisk Add Printer.

# Upewnij się, że w katalogu /etc/cups/ppd/ utworzona została kopia wskazanego pliku PPD o takiej nazwie, jak nazwa drukarki (np. Konica-Minolta-C258.ppd):

# ls /etc/cups/ppd/
# Ustaw domyślne opcje drukowania:

# Options Installed
# Model: C258
# General
# Paper Size: A4
# Kliknij przycisk Set Default Options.

# Utwórz w folderze /etc/cups/ppd/ plik z rozszerzeniem .km o takiej samej nazwie, jak nazwa istniejącego w tym folderze pliku PPD zawierającego konfigurację utworzonej drukarki (np. Konica-Minolta-C258.km):
# W poniższym pliku podstaw za <user> i <pass> swoje dane dostępu do drukarki.
sudo cat > '/etc/cups/ppd/Konica-Minolta-C258.km' <<'EOF'
ACCOUNT_NAME="<user>"
ACCOUNT_PASSWORD="<pass>"
ACCOUNT_COETYPE="0"
EOF

# Uruchom ponownie usługę CUPS:
sudo service cups restart

# Usuń pliki tymczasowe.
# rm -r "$TEMP_DIR"

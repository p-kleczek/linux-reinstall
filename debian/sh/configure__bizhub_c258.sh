#!/bin/bash

# https://ubuntuforums.org/showthread.php?t=2054048

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
unzip -o -q "$PATH_TO_ZIP" -d "$TEMP_DIR"

# Umieść znajdujący się w archiwum folderze <wersja_językowa>/CUPS1.2 plik PPD o końcówce UX (np. KOC759UX.ppd) w folderze /usr/share/ppd/custom/1) i nadaj mu uprawnienia 644:
PPD_TEMP_DIR="${TEMP_DIR}/${DRIVER_VERSION}/${LANGUAGE}/CUPS1.2/"

PPD_FILENAME=$( sudo sh -c "ls \"$PPD_TEMP_DIR\" | grep 'UX.ppd'" )
# PPD_FILENAME=$( sudo ls "$PPD_TEMP_DIR" | grep 'UX.ppd' )

PPD_USR_DIR='/usr/share/ppd/custom'
PPD_USR_FILE="${PPD_USR_DIR}/${PPD_FILENAME}"
sudo cp "${PPD_TEMP_DIR}/${PPD_FILENAME}" "$PPD_USR_DIR"
sudo chmod 755 "${PPD_USR_DIR}"  # foldery wymagają praw do wykonywania, żeby można było przeglądać ich zawartość
sudo chmod 644 "${PPD_USR_FILE}"  # chmod u=rw,go=r

# Dodaj w pliku PPD po wpisie '*% Linux Version' linijki, które spowodują wywołanie odpowiedniego filtra CUPS.
if ! sudo grep -q 'cupsFilter' "${PPD_USR_FILE}"; then
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

# =======================================

PRINTER_NAME='Konica-Minolta-C258'  # nazwa drukarki, którą należy później podać w panelu administratora CUPS (http://localhost:631/admin/) -- to kolejny krok...
PRINTER_ACCOUNT_NAME='pkleczek'  # TODO: <user>  (eg. pk)
PRINTER_ACCOUNT_PASS='14789'  # TODO: <pass>  (eg. biz01)

if [ $PRINTER_ACCOUNT_NAME = '<user>' ] || [ $PRINTER_ACCOUNT_PASS = '<pass>' ]; then
	logerror 'Ustaw wartości zmiennych PRINTER_ACCOUNT_NAME oraz PRINTER_ACCOUNT_PASS zgodnie ze swoimi danymi konta na drukarce.'
	echo '(terminated)'
	exit
fi

# Utwórz w folderze /etc/cups/ppd/ plik z rozszerzeniem .km o takiej samej nazwie, jak nazwa drukarki (np. Konica-Minolta-C258.km).
KM_TEMP_FILE="${TEMP_DIR}/${PRINTER_NAME}.km"
printf '' > "$KM_TEMP_FILE"
echo "ACCOUNT_NAME=\"${PRINTER_ACCOUNT_NAME}\"" >> "$KM_TEMP_FILE"
echo "ACCOUNT_PASSWORD=\"${PRINTER_ACCOUNT_PASS}\"" >> "$KM_TEMP_FILE"
echo "ACCOUNT_COETYPE=\"0\"" >> "$KM_TEMP_FILE"

sudo cp "$KM_TEMP_FILE" "/etc/cups/ppd/${PRINTER_NAME}.km"

# Usuń pliki tymczasowe.
rm -r "$TEMP_DIR"


# Dodaj użytkownika do grupy 'lpadmin' (zob. https://wiki.debian.org/SystemGroups)
sudo usermod -a -G lpadmin $USERNAME

sudo xdg-open 'http://localhost:631/admin/'


printf "\n\n"
echo "Parametry konfiguracyjne:"
echo "  - Nazwa drukarki:  ${PRINTER_NAME}"
echo "  - Plik PPD:  ${PPD_FILENAME}"

cat <<'EOF'


W panelu administratora CUPS (http://localhost:631/admin/) wykonaj poniższe kroki:'

* W przypadku konieczności podania danych logowania, podaj dane użytkownika `root` (na swoim komputerze):
    - nazwa użytkownika: root
    - hasło: <root_password>

* Kliknij w sekcji "Printers" przycisk "Add Printer".

* Wybierz "Other Network Printers → LPD/LPR Host or Printer" i kliknij przycisk "Continue".

* W polu "Connection" wpisz
    lpd://149.156.199.190/print
  i kliknij przycisk "Continue".

* Nadaj drukarce wybraną nazwę (zob. sekcję "Parametry konfiguracyjne" powyżej) i kliknij przycisk "Continue".

* W sekcji "Or Provide a PPD File" kliknij przycisk "Choose File", wybierz odpowiedni plik PPD
  z folderu '/usr/share/ppd/custom/' (zob. sekcję "Parametry konfiguracyjne" powyżej) i naciśnij przycisk "Add Printer".

* Upewnij się, że w katalogu /etc/cups/ppd/ utworzona została kopia wskazanego pliku PPD o takiej nazwie,
  jak nazwa drukarki (np. Konica-Minolta-C258.ppd):
    ls /etc/cups/ppd/

* Ustaw domyślne opcje drukowania:
  - Options Installed
    - Model: C258
  - General
    - Paper Size: A4
  Kliknij przycisk "Set Default Options".


Po wykonaniu powyższych kroków naciśnij dowolny klawisz w terminalu.


EOF


read -p "Press any key to continue... " -n1 -s
echo

# Uruchom ponownie usługę CUPS2.
sudo service cups restart

loginfo 'Konfiguracja drukarki zakończona! -- Wykonaj wydruk testowy.'

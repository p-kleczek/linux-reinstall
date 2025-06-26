#! /bin/bash

# Standardowe pakiety
tlmgr install geometry psnfss latex babel xcolor enumitem multirow booktabs makecell threeparttable cellspace l3packages l3kernel cprotect courier mdwtools filecontents mathtools amsmath amscls was url hyperref graphics tools graphbox titlesec pgf pgfplots tikzscale siunitx csquotes fp etoolbox listings preprint todonotes bigfoot xstring biblatex logreq algorithm2e ifoddpage relsize babel-polish lastpage environ trimspaces etextools xstring ulem import
tlmgr install biber gensymb caption svg trimspaces xcolor transparent pgf tabularray ninecolors stix
# Własne środowiska, komendy
tlmgr install environ
# Symbole (amssymb: amsfonts)
tlmgr install amsfonts tipa
# Matematyka
tlmgr cases polynom
# SVG
tlmgr install catchfile
# Grafika
tlmgr install float caption
# Układ tekstu
tlmgr install varwidth paralist nowidow

# Monografia Mszany Dolnej
tlmgr install verse gmverse
tlmgr install appendix
tlmgr install tocloft
tlmgr install acro translations
tlmgr install imakeidx


# Testy (arkusze egzaminacyjne)
tlmgr install tasks

# Pakiety dla CV (curriculum vitae):
tlmgr install footmisc ragged2e polski enumitem etoolbox xifthen ifmtarg multirow koma-script bold-extra lastpage

# Pakiety dla podręczników programowania:
tlmgr install newtx fontaxes mdframed zref needspace tablefootnote datetime2 tex-gyre

# Prezentacje AGH
tlmgr install beamer textpos hanging comment lstaddons dashrule adjustbox collcell eurosym setspace tikzmark fontspec etex helvetic times
# lstaddons = lstautogobble.sty
# shipunov = boldline.sty
# helvetic = phvr8t.tfm
# times = ptmr8t.tfm

# Cyrlica
tlmgr install collection-langcyrillic babel-russian hyphen-russian
# langcyrillic = ALL-IN-ONE
# $ tlmgr search --global t2a
# cm-lgc - Type 1 CM-based fonts for Latin, Greek and Cyrillic
# hyph-utf8 - Hyphenation patterns expressed in UTF-8
# hyphen-russian - Russian hyphenation patterns.
# hyphen-ukrainian - Ukrainian hyphenation patterns.
# libertinegc - Libertine add-on to support Greek and Cyrillic
# tempora - Greek and Cyrillic to accompany Times
# ukrhyph - Hyphenation Patterns for Ukrainian
# 
sudo apt install -y texlive-lang-cyrillic

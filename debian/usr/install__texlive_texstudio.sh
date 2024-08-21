#!/bin/bash

source config.cfg

# ============================================================================

secure_pkg_install texstudio TeXstudio
secure_pkg_install jabref  # zarządzanie bibliografią Bib(La)TeX

# FIXME: W opcjach Adv. Editor > Special Options > Line Wrapping: Soft Line Wrap at Window Edge
#  /home/pkleczek/texlive/2019/bin/x86_64-linux/

# FIMXE: W opcjach Shortcuts > Editor > Basic Key Mapping zmienić:
# * Move cursor left (1 word): Crtl + Left
# * Move cursor right (1 word): Crtl + Right
# * Next placeholder or one word right: <none>
# * Previous placeholder or one word left: <none>

# FIXME: W opcjach Adv. Editor > Special Options > Monitor open files for external changes > Silently reload saved files on external changes (...): <yes>

# FIXME: W opcjach Editor > Indentation Mode: Keep Indentation

# FIXME: W opcjach General > Files > Max. Recent [Master] Documents: 10

# Instalacja słownika języka polskiego:
# 	https://pl.libreoffice.org/pobieranie/?type=src
# 	sudo cp pl_PL* /usr/share/hunspell/
# 	sudo cp th_pl_PL_v2.dat /usr/share/mythes/

simple_pkg_install xzdec

# Package GUI needs it...
# 	tlmgr --gui
simple_pkg_install perl-tk

# Clean install
# 	https://tex.stackexchange.com/a/95502/44391

# FIXME: instrukcje instalacji ze stron
#  https://www.tug.org/texlive/quickinstall.html
#  https://www.tug.org/texlive/doc/install-tl.html
#  https://tug.org/texlive/acquire.html
#    https://tug.org/texlive/acquire-netinstall.html

# install-tl:
# <cleanup>
# O -> d (basic scheme) -> R
# I (install)

# FIXME: opracować instrukcję ręcznej (re)instalacji


# FIXME: Jeśli chcesz instalować jako root: Usually, you would run tlmgr as root. Which means you will have to add the path to tlmgr to the root's path.
# export PATH=/usr/local/texlive/2019/bin/x86_64-linux:$PATH

# https://tex.stackexchange.com/a/75260/44391 -> instalacja brakujących czcionek

exit

# Initialize tlmgr
tlmgr init-usertree

# Upgrade: https://www.tug.org/texlive/upgrade.html

tlmgr update --self

# Szukanie pakietów:
#   tlmgr search --global --file X.sty

# Szukanie czcionek
#   tlmgr info X.tfm

## Instalacja stadardowych pakietów:
tlmgr install latex standalone l3packages l3kernel cprotect mdwtools filecontents mathtools amscls was url hyperref tools graphbox titlesec siunitx csquotes etoolbox preprint todonotes bigfoot biblatex logreq algorithm2e ifoddpage relsize lastpage environ trimspaces etextools titlesec setspace stmaryrd
tlmgr install import paralist collectbox pdfescape letltxmacro bitset collcell ifmtarg
tlmgr install zref tablefootnote soul totcount

# Obliczenia
tlmgr install fp fltpoint

# Diagnostyka składu, komentarze itp.
tlmgr install comment lipsum-polish

# Daty
tlmgr install datetime2 datetime2-polish

# Bibliografia
tlmgr install biber

# Spis treści
tlmgr install minitoc tocloft

# Diagnostyka (LaTeX internals)
tlmgr install fmtcount

# Programowanie (klas, pakietów), kompilacja warunkowa
tlmgr install ncctools xifthen xstring xargs #afterpackage

# Układ strony, elementów i tekstu
tlmgr install needspace geometry adjustbox nowidow tools tabto-ltx microtype hyphenat changepage # tools = afterpage; changepage = adjustwidth

# Formatowanie elementów (tekstu), kolory itp.
tlmgr install ragged2e footmisc upquote siunitx enumitem xcolor pbox ulem

# Tabele, ilustracje
tlmgr install multirow booktabs makecell threeparttable graphics float caption ltablex newfloat epstopdf
tlmgr install shipunov  # zawiera pakiet `boldline`

# Algorytmy
tlmgr install algorithms lineno

# PGF (TikZ)
tlmgr install pgf pgfplots tikzscale tikz-3dplot tikzmark

# Lokalizacja
tlmgr install babel babel-polish polski tracklang

# Czcionki
tlmgr install symbol fonttable psnfss rsfs courier ec times amsfonts newtx fontaxes mweights tex-gyre helvetic txfonts fbb cabin
tlmgr install inconsolata palatino mathpazo
# Kodowania znaków
tlmgr install ly1
# Symbole
tlmgr install amsmath eurosym fourier fontawesome

# Elementy graficzne
tlmgr install dashrule mdframed

# Prezentacje
tlmgr install beamer translator textpos hanging

# Listingi
tlmgr install listings lstaddons
tlmgr install minted fvextra fancyvrb catchfile framed

# == Niszowe ==

# Struktury drzewiaste (np. hierarchia plików)
tlmgr install forest



# Aktualizacja zainstalowanych pakietów:
tlmgr update --all


# FIXME: w TeXStudio ustawić w opcjach Build > Build Options > Additional Search Paths > Commands ($PATH):
#  /home/pkleczek/texlive/2019/bin/x86_64-linux/

#!/bin/bash

source config.cfg

# ============================================================================

MATLAB_VERSION='R2018b'

MATLAB_APP_DIR="/usr/local/MATLAB/$MATLAB_VERSION"

MATLAB_ZIP="$HOME/debian_reinstall/apps_archives/matlab_${MATLAB_VERSION}_glnxa64.zip"
MATLAB_TEMP="$HOME/matlab_temp"

program_name="MATLAB $MATLAB_VERSION"
if [ ! -d "$MATLAB_APP_DIR" ]; then
    mkdir -p $MATLAB_TEMP
    unzip $MATLAB_ZIP -d $MATLAB_TEMP
    sh "$MATLAB_TEMP/install"

    # Aby zmiany ścieżek były trwałe (pomiędzy uruchomieniami MATLAB-a), należy nadać użytkownikowi uprawienia do ich modyfikacji.
    chown $USERNAME -R "$MATLAB_APP_DIR/toolbox/local/pathdef.m"
    chmod -R +w "$MATLAB_APP_DIR/toolbox/local/pathdef.m"

    # Uruchamianie MATLAB-a z menu start.
    simple_pkg_install matlab-support
    simple_pkg_install build-essential

    # Usuń błędy JVM podczas dołączania/odłączania dodatkowego monitora
    # (java.lang.ClassCastException: sun.awt.image.BufImgSurfaceData cannot be cast to sun.java2d.xr.XRSurfaceData)
    # REF:  https://www.mathworks.com/matlabcentral/answers/373897-external-monitor-throws-java-exception#answer_315689
    echo '-Dsun.java2d.xrender=false' | sudo tee "$MATLAB_APP_DIR/bin/glnxa64/java.opts"

    # Skonfiguruj kompilator plików MEX (dla C++).
    matlab -r 'mex -setup C++; quit'

    rm -r $MATLAB_TEMP

    echoinf "$program_name successfully installed."
else
    echoinf "$program_name already installed."
fi

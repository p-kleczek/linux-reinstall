#!/bin/bash

source config.cfg

# ============================================================================


AGH_DIR="$DOCS/AGH"
TEACHING_DIR="$AGH_DIR/Dydaktyka"

PHD_DIR="$DOCS/PhD"


clone_git_repo 'useful-matlab-toolbox' 'BitBucket' 'plkleczek' 'plkleczek' "$DOCS/MATLAB"


clone_git_repo 'air_inf2' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR/[AiR-Inf2] Informatyka 2"

clone_git_repo 'pub_sample' 'BitBucket' 'pkleczek_agh' 'pkleczek_agh' "$AGH_DIR/Publikowanie"

clone_git_repo 'wsi_repo_utils' 'BitBucket' 'pkleczek_agh' 'pkleczek_agh' "$PHD_DIR"
clone_git_repo 'epidermis-morphometry' 'BitBucket' 'pkleczek_agh' 'pkleczek_agh' "$DOCS/MATLAB"



clone_git_repo 'debian-reinstall' 'BitBucket' 'plkleczek' 'plkleczek' "$DOCS/Projects"


exit







USE_TEST=1

if [ $USE_TEST -eq 1 ]; then
# ----------------------------------------------------------------------------

MATLAB_VERSION='R2018b'

# TODO: check if exists
# path:  /usr/local/MATLAB/R2018b

MATLAB_APP_DIR="/usr/local/MATLAB/$MATLAB_VERSION"

MATLAB_ZIP="/home/$USERNAME/debian_reinstall/apps_archives/matlab_${MATLAB_VERSION}_glnxa64.zip"
MATLAB_TEMP="/home/$USERNAME/matlab_temp"

program_name="MATLAB $MATLAB_VERSION"
if [ ! -d "$MATLAB_APP_DIR" ]; then
    echo 'XXX'
    exit

    sudo -u $USERNAME -i mkdir -p $MATLAB_TEMP
    sudo -u $USERNAME -i unzip $MATLAB_ZIP -d $MATLAB_TEMP
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
    echo '-Dsun.java2d.xrender=false' > "$MATLAB_APP_DIR/bin/glnxa64/java.opts"

    # Skonfiguruj kompilator plików MEX (dla C++).
    matlab -r 'mex -setup C++; quit'

    rm -r $MATLAB_TEMP

    echoinf "$program_name successfully installed."
else
    echoinf "$program_name already installed."
fi


# ----------------------------------------------------------------------------
exit
fi

# ============================================================================

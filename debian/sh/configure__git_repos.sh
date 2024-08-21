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

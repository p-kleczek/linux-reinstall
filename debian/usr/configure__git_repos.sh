#!/bin/bash

source config.cfg

# ============================================================================

AGH_DIR="${DOCS}/AGH"

TEACHING_DIR="${AGH_DIR}/Dydaktyka"
AGH_PROJECTS_DIR="${AGH_DIR}/Projekty"
PUBLISHING_DIR="${AGH_DIR}/Publikowanie"

PHD_DIR="${DOCS}/PhD"

PRIV_PROJECTS_DIR="${DOCS}/Projects"

# Narzędzia, MWE
clone_git_repo 'useful-matlab-toolbox' 'BitBucket' 'plkleczek' 'plkleczek' "$DOCS/MATLAB"
clone_git_repo 'pub_sample' 'BitBucket' 'pkleczek_agh' 'pkleczek_agh' "$PUBLISHING_DIR"
clone_git_repo 'debian-reinstall' 'BitBucket' 'plkleczek' 'plkleczek' "$DOCS/Projects"
clone_git_repo 'latex_mwe' 'BitBucket' 'pkleczek_agh' 'pkleczek_agh' "${AGH_DIR}"

# Dydaktyka
clone_git_repo 'air_inf2' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR/[AiR-Inf2] Informatyka 2"
clone_git_repo 'air_inf1_material' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "${TEACHING_DIR}"
clone_git_repo 'agh-tests' 'BitBucket' 'plkleczek' 'plkleczek' "$TEACHING_DIR"
clone_git_repo 'air_inf1_lab_cpp' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR"
clone_git_repo 'air_inf1_lab_cpp_exercises' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR"
clone_git_repo 'algo_tsp_skeleton' 'GitHub' 'pkleczek-agh' 'pkleczek-agh' "$TEACHING_DIR/~PROGRAMMING/"
#
# Narzędzia
clone_git_repo 'exercises_repo_generator' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR"
clone_git_repo 'upel_tools' 'BitBucket' 'pkleczek_agh' 'pkleczek_agh' "${TEACHING_DIR}"
#
# C/C++
clone_git_repo 'ccpp_clion' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR"
clone_git_repo 'lang_c__priv' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR"
clone_git_repo 'lang_c__exercises' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR"
clone_git_repo 'lang_cpp__priv' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR"
clone_git_repo 'lang_cpp__exercises' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR"
clone_git_repo 'lang_cpp__exercises__en' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR"
clone_git_repo 'prog_lectures' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR"
#
# Python
clone_git_repo 'lang_python__priv' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR"
clone_git_repo 'lang_python__exercises' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$TEACHING_DIR"

# PhD
clone_git_repo 'wsi_repo_utils' 'BitBucket' 'pkleczek_agh' 'pkleczek_agh' "$PHD_DIR"
clone_git_repo 'epidermis-morphometry' 'BitBucket' 'pkleczek_agh' 'pkleczek_agh' "$DOCS/MATLAB"
clone_git_repo 'epidermis-segmentation' 'BitBucket' 'plkleczek' 'plkleczek' "$DOCS/MATLAB"
clone_git_repo 'bg-segmentation' 'BitBucket' 'pkleczek_agh' 'pkleczek_agh' "$DOCS/MATLAB"
# 
clone_git_repo 'phd_thesis' 'BitBucket' 'pkleczek_agh' 'pkleczek_agh' "${PHD_DIR}"
clone_git_repo 'phd_exam_slides' 'BitBucket' 'pkleczek_agh' 'pkleczek_agh' "${PHD_DIR}"

# Publikacje
clone_git_repo 'publishing_snippets' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$PUBLISHING_DIR"
# 
clone_git_repo 'pub_nests' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "$PUBLISHING_DIR"
clone_git_repo 'sota_in_nns__chapter' 'BitBucket' 'pkleczek_agh' 'mdig-agh' "${PUBLISHING_DIR}/[CHA] SotA in NNs"

# Projekty - AGH
# clone_git_repo 'xpdl_aux' 'BitBucket' 'pkleczek_agh' 'pkleczek_agh' "${AGH_PROJECTS_DIR}/XPDL"
clone_git_repo 'openagh_cpp' 'BitBucket' 'pkleczek_agh' 'pkleczek_agh' "${TEACHING_DIR}"

# Projekty - prywatne
clone_git_repo 'prof_borys' 'BitBucket' 'plkleczek' 'plkleczek' "${PRIV_PROJECTS_DIR}"

# Poradniki itp.
clone_git_repo 'aghdpl' 'GitHub' 'pkleczek-agh' 'pkleczek-agh' "$TEACHING_DIR"

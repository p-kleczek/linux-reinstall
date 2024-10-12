#! /bin/bash

# See: https://help.gnome.org/admin/system-admin-guide/stable/mime-types-custom.html.en

# See also:
# - https://superuser.com/questions/21626/ubuntu-change-the-default-program-used-to-open-a-type-of-file

# ----------------------

MIME_TYPE="application/graphml"
EXTENSION="graphml"

# ----------------------

echo "Registering application/graphml MIME type..."

MIME_DIR="${HOME}/.local/share/mime"

mkdir -p ${MIME_DIR}/packages
tee ${MIME_DIR}/packages/application-graphml.xml > /dev/null <<EOT
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="${MIME_TYPE}">
    <comment>GraphML format (http://graphml.graphdrawing.org/)</comment>
    <glob pattern="*.${EXTENSION}"/>
  </mime-type>
</mime-info>
EOT

update-mime-database ${MIME_DIR}

# Verify if everything is OK:
TEST_FILE=test.${EXTENSION}
touch ${TEST_FILE}
tee ${TEST_FILE} > /dev/null <<EOT
TEST
EOT
gio info ${TEST_FILE} | grep "standard::content-type"
# FIXME: Compare the output with the expected value:
#`  standard::content-type: application/graphml`
rm ${TEST_FILE}

# ----

echo "Registering yEd as default application for application/graphml MIME type..."

APPS_DIR="~/.local/share/applications"
YED_DESKTOP_FILE=$(find ${APPS_DIR} -name '*yEd*.desktop')

tee -a ${YED_DESKTOP_FILE} > /dev/null <<EOT
MimeType=${MIME_TYPE}
EOT

update-desktop-database ${APPS_DIR}

# Verify if everything is OK:
gio mime ${MIME_TYPE}
# FIXME: Should be 
# Default application for “application/graphml”: install4j_1yk73ep-yEd.desktop
# -> ${YED_DESKTOP_FILE}

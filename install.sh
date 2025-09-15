#!/bin/sh

# =================================================================
#      SAIKAT-HOTSPOT-SERVER -- UNIVERSAL INSTALLER SCRIPT
# =================================================================

REPO_URL="https://raw.githubusercontent.com/jaybhit-sudo/saikat-hotspot-server/main"
FEED_CONFIG_LINE="src/gz saikat_hotspot_repo ${REPO_URL}"
CUSTOM_FEEDS_FILE="/etc/opkg/customfeeds.conf"

# Function to display messages
log() {
    echo "=> $1"
}

# 1. Add the custom repository if it's not already there
if ! grep -q "${REPO_URL}" "${CUSTOM_FEEDS_FILE}"; then
    log "Adding Saikat Hotspot repository..."
    echo "${FEED_CONFIG_LINE}" >> "${CUSTOM_FEEDS_FILE}"
else
    log "Repository already exists."
fi

# 2. Update the package list
log "Updating package lists..."
opkg update

# 3. Install the package
log "Attempting to install saikat-hotspot-server..."
opkg install saikat-hotspot-server

if [ $? -eq 0 ]; then
    log "The installation script has finished. Your hotspot setup should begin now."
else
    log "Installation failed. Please check your internet connection and try again."
fi

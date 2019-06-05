#!/bin/bash
#
# - Downloads a compressed file;
# - Extracts all its contents;
# - Make the binary executable;
# - Executes the binary with the secified arguments.
#
DOWNLOAD_LINK="https://ftp.mozilla.org/pub/firefox/releases/52.0esr/linux-x86_64/fr/firefox-52.0esr.tar.bz2"
DOWNLOAD_TARGET_FILE="firefox-52.0esr.tar.bz2"
DOWNLOAD_TARGET_DIR="/tmp"
DOWNLOAD_TARGET="$DOWNLOAD_TARGET_DIR/$DOWNLOAD_TARGET_FILE"
# Path to file after extracting it in the $DOWNLOAD_TARGET_DIR
BIN_DIR="firefox"
BIN_NAME="firefox"
BIN_PATH="$DOWNLOAD_TARGET_DIR/$BIN_DIR/$BIN_NAME"
# Arguments to pass to the binary
ARGUMENTS='-no-remote http://localhost:4200'

# Only download if the compressed file does not exist
if [ ! -f "$DOWNLOAD_TARGET" ]; then
  wget "$DOWNLOAD_LINK" -O "$DOWNLOAD_TARGET" 2>&1 | \
    sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | \
    zenity --progress \
      --width=600 \
      --height=100 \
      --title="Downloading to $DOWNLOAD_TARGET" \
      --auto-close \
      --auto-kill
fi


# Extract all files, overwriting previous
rm -r "$DOWNLOAD_TARGET_DIR/$BIN_DIR"
tar xvfj "$DOWNLOAD_TARGET" -C "$DOWNLOAD_TARGET_DIR" | \
  zenity --progress \
    --pulsate \
    --title="Extracting..." \
    --text="$DOWNLOAD_TARGET_FILE" \
    --auto-close \
    --auto-kill

# Add execute permissions
chmod +x $BIN_PATH

# Run the executable
$BIN_PATH $ARGUMENTS

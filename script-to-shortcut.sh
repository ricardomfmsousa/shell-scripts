#!/bin/bash
# Creates a desktop shortcut incorporating a given script
# $1: shortcut name
# $2: script path

# Define the shorcut file name/path
SHORTCUT_PATH="$1.desktop"

# Encode the whole script with no word wrapping
ENCONDED_SCRIPT=`base64 -w0 $2` &&

# Command to execute the encoded script
EXEC_ENCODED_SCRIPT="bash -c \"echo $ENCONDED_SCRIPT | base64 -d | bash\"" &&

# Create the shortcut file
echo "\
[Desktop Entry]
Type=Application
X-GNOME-Autostart-enabled=true
Name=$1
Exec=$EXEC_ENCODED_SCRIPT\
" > "$SHORTCUT_PATH" &&

# Make the shortcut executable
chmod +x "$SHORTCUT_PATH" &&
echo "$SHORTCUT_PATH added to `pwd`"


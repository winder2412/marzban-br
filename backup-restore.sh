#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <username@hostname>"
    exit 1
fi

# Extract the server variable from the argument
SERVER="$1"
REMOTE_VAR_FILE="/var/lib/marzban"
LOCAL_VAR_FILE="/var/lib/marzban"
REMOTE_OPT_FILE="/opt/marzban"
LOCAL_OPT_FILE="/opt/marzban"

sudo bash -c "$(curl -sL https://github.com/Gozargah/Marzban-scripts/raw/master/marzban.sh)" @ install
# Check if the local file exists and remove it if it does
if [ -e "$LOCAL_VAR_FILE" ]; then
    rm -rf "$LOCAL_VAR_FILE"
fi

if [ -e "$LOCAL_OPT_FILE" ]; then
    rm -rf "$LOCAL_OPT_FILE"
fi
# Connect to the server and copy the file to itself
sftp $SERVER <<EOF
get $REMOTE_VAR_FILE $LOCAL_VAR_FILE
get $REMOTE_OPT_FILE $LOCAL_OPT_FILE
EOF


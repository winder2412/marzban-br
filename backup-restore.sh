#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <username@hostname>"
    exit 1
fi

# Extract the server variable from the argument
SERVER="$1"
VAR_DIR="/var/lib/marzban"
OPT_DIR="/opt/marzban"

sudo bash -c "$(curl -sL https://github.com/Gozargah/Marzban-scripts/raw/master/marzban.sh)" @ install
# Check if the local file exists and remove it if it does
if [ -e "$VAR_DIR" ]; then
    rm -rf "$VAR_DIR"
fi

if [ -e "$OPT_DIR" ]; then
    rm -rf "$OPT_DIR"
fi
# Connect to the server and copy the file to itself
scp -r $SERVER:$VAR_DIR $VAR_DIR
scp -r $SERVER:$OPT_DIR $OPT_DIR

marzban restart

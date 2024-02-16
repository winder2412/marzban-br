#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <username@hostname> <password>"
    exit 1
fi

# Extract the server and password variables from the arguments
SERVER="$1"
PASSWORD="$2"
VAR_DIR="/var/lib/marzban"
OPT_DIR="/opt/marzban"

# Check if the local file exists and remove it if it does
if [ -e "$VAR_DIR" ]; then
    rm -rf "$VAR_DIR"
fi

if [ -e "$OPT_DIR" ]; then
    rm -rf "$OPT_DIR"
fi
# Connect to the server and copy the file to itself
sshpass -p "$PASSWORD" scp -o StrictHostKeyChecking=no -r "$SERVER:$VAR_DIR" "$VAR_DIR"
sshpass -p "$PASSWORD" scp -o StrictHostKeyChecking=no -r "$SERVER:$OPT_DIR" "$OPT_DIR"


marzban restart


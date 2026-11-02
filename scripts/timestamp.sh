#!/usr/bin/env bash
SOURCE="$1"
DIR="$HOME/backups/"
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")

FILE_NAME=$(basename "$SOURCE")
DEST_FILE="${DIR}/${FILE_NAME}_${TIMESTAMP}.bak"

mkdir -p "DIR"

echo "Backing up '$SOURCE' to '$DEST_FILE'..."

cp "$SOURCE" "$DEST_FILE"

CP_STATUS=$?
echo "Backup finished"
echo "$CP_STATUS"

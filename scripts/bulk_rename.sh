#!/usr/bin/env bash

TARGET_DIR="${1:-./photos}"
PREFIX="${2:--2026-holiday}"

if [[ ! -d "$TARGET_DIR" ]]; then
	echo "Error: Directory doesn't exist"
	exit 1
fi

count=0
for filepath in "$TARGET_DIR"/IMG_*.jpg; do
	[[ -e "$filepath"  ]] || continue

	filename=$(basename "$filepath")
	newname="${filename/#IMG_/${PREFIX}-}"
	newpath="${TARGET_DIR}/${newname}"

	mv "$filepath" "$newpath"
	echo "Renamed: '$filename' to '$newname'"
	((count ++))
done
echo "Done , renamed '$count' file"

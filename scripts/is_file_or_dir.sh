#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo  "No args passed..."
    exit 1
fi

PATH="$1"
if [[ ! -e "$PATH"  ]]; then
	echo "Path doesn't exists ..."
	exit 1
fi

if [[ -f "$PATH" ]]; then
	echo "Path exists and it's a regular file..."
elif [[ -d "$PATH" ]]; then
        echo "Path exists and it's a directory..."
fi


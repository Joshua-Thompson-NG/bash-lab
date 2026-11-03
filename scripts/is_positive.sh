#!/usr/bin/env bash
 
if [[ -z "$1" ]]; then
	echo "No argument given ..."
	exit 1
fi

args="$1"



if [[ "$args" -gt 0 ]]; then
	echo "Number is positive"
elif [[ "$args" -lt 0 ]]; then
        echo "Number is negative"
else
	echo "Number is zero"
fi

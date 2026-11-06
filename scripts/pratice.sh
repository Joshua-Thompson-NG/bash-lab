#!/usr/bin/env bash

name="stranger"
verbose=0

while getopts ":n:vh" opt; do
	case "$opt" in
		n) name="$OPTARG" ;;
		v) verbose=1 ;;
		h) echo "Usage: $0 [-n name] [-v]"; exit 0 ;;
        	:) echo "Option -$OPTARG needs a value" >&2; exit 2 ;;
       		\?) echo "Unknown option: -$OPTARG" >&2; exit 2 ;;
	esac
done

shift $(( OPTIND -1 ))

echo "Hello $name" 
echo "Leftover args: $*"

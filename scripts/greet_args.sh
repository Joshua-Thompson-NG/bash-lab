#!/usr/bin/env bash

name="stranger"
is_uppercase="false"

while getopts ":n:u" opt ; do
	case "$opt" in
		n) name="$OPTARG" ;;
		u) is_uppercase="true" ;;
		:) echo "Option -$OPTARG needs a value" >&2; exit 2 ;;
       		\?) echo "Unknown option: -$OPTARG" >&2; exit 2 ;;
	esac
done

shift $(( OPTIND - 1 ))

if [[ "$is_uppercase" == "true" ]]; then
	echo "Hello user ${name^^}, how are you doing today?"
else
	echo "Hello user $name, how are you doing today?"
fi

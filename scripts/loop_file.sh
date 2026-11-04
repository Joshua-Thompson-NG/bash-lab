#!/usr/bin/env bash

for file in /etc/*.conf; do
	[[ -e "$file"  ]] || continue
	count=$(wc -l < "$file")
	echo "$file: $count"
done

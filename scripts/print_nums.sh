#!/usr/bin/env bash

for ((i = 1; i <= 20; i++)); do
	if (( i % 3 == 0  )); then
		continue
	fi
	echo "$i"
done

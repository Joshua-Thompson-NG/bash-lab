#!/usr/bin/env bash
set -euo pipefail

file_path="${1:-hosts.txt}"
target_port=22 # SSH

# validation
if [[ ! -f "$file_path"  ]]; then
	echo "Error: Inventory file $file_path does not exist..." >&2
	exit 1
fi

if [[ ! -r "$file_path"  ]]; then
        echo "Error: Inventory file $file_path is not readable..." >&2
        exit 1
fi

echo "-------------------------------"
echo "-------------------------------"

while IFS= read -r line; do
	[[ -z "$line" || "$line" =~ ^# ]] && continue
	
	if ping -c 1 -W 2 "$line" &> /dev/null; then
		ping_status="UP/REACHABLE"
	else
		ping_status="DOWN/UNREACHABLE"
	fi

	if timeout 2 bash -c "(: < /dev/tcp/$line/$target_port) &> /dev/null" 2> /dev/null; then
		port_status="Open"
	else
		port_status="Closed"
	fi

	echo "Host: $line, Ping Status: $ping_status, Port Status: $port_status"
done < "$file_path"	

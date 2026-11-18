#!/usr/bin/env bash
set -euo pipefail

if [[ $# -eq 0 ]]; then
	echo "Error: No args provided..." >&2
	exit 1
fi

service_name="$1"	
timestamp="$(date +"%Y-%m-%d %H:%M:%S")"


if systemctl is-active --quiet "$service_name"; then
	echo "Service is running..."
else
	
	echo "$timestamp [WARN]  Service $service_name is not running.." | tee -a error.log >&2
	exit 1
fi


#!/usr/bin/env bash
set -euo pipefail

disk_usu="$(df / | awk 'NR==2 {print $5}' | tr -d '%')"
threshold="${1:-80}" # default of 80
timestamp="$(date +"%Y-%m-%d %H:%M:%S")"

if (( disk_usu >= threshold )); then

        echo "$timestamp [WARN] Disk usage is above the threshold $threshold... " | tee -a disk_usage.log >&2
        exit 1

else
        echo "Disk is healthy..."

fi 

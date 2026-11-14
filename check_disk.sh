#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"

disk_usu="$(df / | awk 'NR==2 {print $5}' | tr -d '%')"
threshold="${1:-80}" # default of 80
timestamp="$(date +"%Y-%m-%d %H:%M:%S")"

if (( disk_usu >= threshold )); then

        log_warn "Disk usage is above the threshold $threshold... " | tee -a disk_usage.log >&2
        exit 1

else
        log_info "Disk is healthy..."

fi 

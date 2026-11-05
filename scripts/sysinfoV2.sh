#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "${SCRIPT_DIR}/../lib/lib.sh"


check_system_health() {
	local threshold="${1:-80}"
	local hostname
        local uptime
        local mem_available
       	local disk_usuage
	[[ "$threshold" =~ ^[0-9]+$ ]] || die "Threshold '$threshold' must be a valid integer!" 2
	hostname=$(hostname)
	uptime=$(uptime -p)
	mem_available=$(free -h | awk '/^Mem:/ {print $7}')
	disk_usuage=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

	echo "================================="
	printf "%-18s %s \n" "SYSTEM METRIC" "VALUE"
	echo "================================="


	printf "%-18s %s\n" "Hostname:" "$hostname"
	printf "%-18s %s\n" "Uptime:" "$uptime"
	printf "%-18s %s\n" "Disk Usage:" "$disk_usuage %"
	printf "%-18s %s\n" "Memory Available:" "$mem_available"
	printf "%-18s %s\n" "Disk Threshold:" "$threshold%"
	echo "================================="

	if [[ "$disk_usuage" -gt "$threshold" ]]; then
		die "WARNING!, Disk Usage is over the threshold " 1

	else
		log_info "Disk is healthy."
	fi
}

check_system_health "$1"

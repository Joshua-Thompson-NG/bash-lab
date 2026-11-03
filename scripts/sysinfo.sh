#!/usr/bin/env bash

DISK_USAGE_NUM=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
DISK_USAGE=$(df / | awk 'NR==2 {print $5}')
HOSTNAME=$(hostname)
UPTIME=$(uptime -p)
MEM_AVAILABLE=$(free -h | awk '/^Mem:/ {print $7}')

THRESHOLD="${1:-80}"


echo "================================="
printf "%-18s %s \n" "SYSTEM METRIC" "VALUE"
echo "================================="


printf "%-18s %s\n" "Hostname:" "$HOSTNAME"
printf "%-18s %s\n" "Uptime:" "$UPTIME"
printf "%-18s %s\n" "Disk Usage:" "$DISK_USAGE ($DISK_USAGE_NUM%)"
printf "%-18s %s\n" "Memory Available:" "$MEM_AVAILABLE"
printf "%-18s %s\n" "Disk Threshold:" "$THRESHOLD%"
echo "================================="


if [[ "$DISK_USAGE_NUM" -gt "$THRESHOLD" ]]; then
	echo "WARNING!, Disk Usage is over the threshold " 
	exit 1
else
	echo "Disk is healthy."
	exit 0
fi

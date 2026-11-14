#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"

uptime="$(uptime -p)"
cur_user="$(whoami)"
hostname="$(hostname)"
disk_usu="$(df / | awk 'NR==2 {print $5}' | tr -d '%')"
threshold="${1:-80}" # default of 80


read -r load_1 load_5 load_15 _ < /proc/loadavg
read -r total used_eff <<< "$(free -m | awk '/^Mem:/ {print $2, $2 - $7}')"
ip_add="$(hostname -I)"
kernel="$(uname -r)"


cat << EOF
----------------------------------
SYSTEM INFO
----------------------------------

HOST INFORMATION
----------------------------------
Uptime: $uptime
Current User: $cur_user
Hostname: $hostname
IP Address: $ip_add
KERNEL: $kernel

LOAD AVERAGE
----------------------------------
1-Min Load: $load_1
5-Min Load: $load_5
15-Min Load: $load_15

MEMORY
----------------------------------
Total Memory: ${total}MB
Used Memory: ${used_eff}MB
----------------------------------
EOF

if (( disk_usu >= threshold  )); then
	log_warn "Disk usage is above the threshold $threshold..."
else
	log_info "Disk is healthy..."
fi

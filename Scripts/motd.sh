#!/usr/bin/env bash

set -euo pipefail

uptime="$(uptime -p)"
cur_user="$(whoami)"
hostname="$(hostname)"
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


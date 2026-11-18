#!/usr/bin/env bash
set -euo pipefail

log_path="${1:-/var/log/auth.log}"

# shellcheck source=logger.sh
source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"


# Validation
if [[ ! -f "$log_path" ]]; then
	log_error "Log file $log_path does not exist or is not readable..."
	exit 1
fi


extracted_ips=$(grep "Failed password" $log_path| grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' || true)

if [[ -z "$extracted_ips" ]]; then 
	echo "Log File: $log_path"
	echo "No failed auth attempts found..."
	exit 0
fi

total_attempts=$(echo "$extracted_ips" | wc -l | tr -d ' ' )
unique_attempts=$(echo "$extracted_ips" | sort -u | wc -l | tr -d ' ')
top_5=$(echo "$extracted_ips" | sort | uniq -c | sort -rn | head -n 5)

echo "=========================================="
echo " Failed Attempts Report "
echo "=========================================="
echo "Log File: $log_path"
echo "Total Attempts: $total_attempts"
echo "Unique IPs: $unique_attempts"
echo "=========================================="
echo "Top 5 Attack IPs:"
echo "$top_5"


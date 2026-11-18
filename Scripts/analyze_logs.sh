#!/usr/bin/env bash
set -euo pipefail

log_file="${1:-access.log}"

# shellcheck source=logger.sh
source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"

if [[ ! -f "$log_file" ]] ||  [[ ! -r "$log_file" ]]; then
	log_error "Log file $log_file does not exist or is not readable..."
	exit 1
fi

echo "=========================================="
echo " Log Analysis Report: $log_file"
echo "=========================================="
echo ""

total_requests=$(wc -l < "$log_file" | tr -d ' ')
echo "Total Requests Processed: $total_requests"
echo ""

if [[ "$total_requests" -eq 0 ]]; then
	log_info "The log file is empty. Nothing to analye..."
	exit 0
fi

echo "--- Request Count per HTTP Status Code ---"
awk '{print $9}' "$log_file" \
	| sort \
	| uniq -c \
	| sort -rn \
	| awk '{printf "Status %5s : %s\n", $2, $1}'

echo ""

echo "--- Top 5 Requested Endpoints ---"
awk '{print $7}' "$log_file" \
        | sort \
        | uniq -c \
        | sort -rn \
	| head -n 5 \
        | awk '{printf "%8s : %s\n", $1, $2}'

echo ""

echo "--- Top 5 Client IP Addresses ---"
awk '{print $1}' "$log_file" \
        | sort \
        | uniq -c \
        | sort -rn \
        | head -n 5 \
        | awk '{printf "%8s : %s\n", $1, $2}'

echo ""

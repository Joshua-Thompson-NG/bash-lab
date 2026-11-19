#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=logger.sh
source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"

json_file="${1:-containers.json}"

# Validation
# Check if installed
if ! command -v jq &> /dev/null; then
        log_error "jq is not installed..."
        exit 1
fi

#Verify json is readable and it exists.
if [[ ! -f "$json_file" ]] || [[ ! -r "$json_file" ]]; then
        log_error "JSON file $json_file does not exist or is not readable..."
        exit 1
fi

# check if valid JSON
if ! jq empty "$json_file" 2>/dev/null; then
        log_error "Invalid JSON format in $json_file..."
        exit 1
fi

# Extract everything
while IFS=$'\t' read -r name image status ip port region; do
    printf "%-15s %-18s %-9s %-15s %-6s %-10s\n" \
        "$name" "$image" "$status" "$ip" "$port" "$region"

    total=$((total + 1))
    if [[ "$status" == "running" ]]; then
        running=$((running + 1))
    fi
done < <(jq -r '.containers[] | [
        (.name   // "N/A"),
        (.image  // "N/A"),
        (.status // "N/A"),
        (.ip     // "N/A"),
        (.port   // "N/A"),
        (.region // "N/A")
    ] | @tsv' "$json_file")

# Main
echo "=========================================="
echo "         CONTAINER STATUS REPORT          "
echo "=========================================="
echo ""
echo"Total containers : $total"
echo "Running          : $running"
echo "Not running      : $((total - running))"
echo "=========================================="

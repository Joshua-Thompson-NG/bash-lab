#!/usr/bin/env bash

#  colors
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_YELLOW='\033[0;33m'
readonly COLOR_RED='\033[0;31m'
readonly COLOR_RESET='\033[0m'

log_message () {
	local level="$1"
	local color="$2"
	local message="$3"
	local timestamp

	timestamp=$(date -u +"%Y-%m-%d %H:%M:%S")
	printf "%b[%s] [%s]%b %s \n" "${color}" "${timestamp}" "${level}" "${COLOR_RESET}" "${message}"
}

log_info() {
	local message="$1"
	log_message "INFO" "${COLOR_GREEN}" "${message}"
}

log_warn() {
        local message="$1"
        log_message "WARN" "${COLOR_YELLOW}" "${message}"
}

log_error() {
        local message="$1"
        log_message "ERROR" "${COLOR_RED}" "${message}" >&2
}

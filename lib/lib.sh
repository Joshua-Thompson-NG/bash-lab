#!/usr/bin/env bash

# Shared logging and utility libary

readonly COLOR_GREEN="\033[0;32m" # ANSI escape codes - when printed to modern terminal they show up as colour
readonly COLOR_RED="\033[0;31m"
readonly COLOR_YELLOW="\033[0;33m"
readonly COLOR_RESET="\033[0m" # This makes sure the terminal doesn't stay a certain colour forever

get_timestamp() {
	date "+%Y-%m-%d %H:%M:%S"
}

log_info() {
	local msg="$1"
	local ts
	ts=$(get_timestamp)
	printf "${COLOR_GREEN}[%s] [INFO]${COLOR_RESET} %s\n" "$ts" "$msg" 
}

log_warn() {
        local msg="$1"
        local ts
        ts=$(get_timestamp)
        printf "${COLOR_YELLOW}[%s] [WARN]${COLOR_RESET} %s\n" "$ts" "$msg" >&2
}

log_error() {
        local msg="$1"
        local ts
        ts=$(get_timestamp)
        printf "${COLOR_RED}[%s] [ERROR]${COLOR_RESET} %s\n" "$ts" "$msg" >&2
}

die() {
	local msg="$1"
	local exit_code="${2:-1}"
	log_error "$msg"
	exit "$exit_code"
}

require_md() {
	local cmd="$1"
	
	if ! command -v  "$cmd" &> /dev/null; then
		die "Required command '$cmd' is not installed. Please install it and try again."
	fi
}







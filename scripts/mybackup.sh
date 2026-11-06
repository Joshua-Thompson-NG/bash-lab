#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "${SCRIPT_DIR}/../lib/lib.sh"

source_dir=""
dest_dir=""
compress=false

usage() {
    cat << EOF
Usage: $(basename "$0") -s <source_dir> -d <dest_dir> [-c] [-h]

Backs up a source directory into a tar (or compressed tar.gz) archive.

Options:
  -s <path>   Source directory to back up (Required)
  -d <path>   Destination folder to store the backup (Required)
  -c          Enable gzip compression (.tar.gz)
  -h          Display this help message

Example:
  $(basename "$0") -s ~/day9_app -d ~/backups -c
EOF
}

while getopts ":s:d:ch" opt ; do
	case "$opt" in
		s) source_dir="$OPTARG" ;;
		d) dest_dir="$OPTARG" ;;
		c) compress=true ;;
		h) usage; exit 0 ;;
		:) echo "Option -$OPTARG needs a value" >&2; exit 2 ;;
       		\?) echo "Unknown option: -$OPTARG" >&2; exit 2 ;;
	esac
done

shift $(( OPTIND - 1 ))


if [[ -z "$source_dir" || -z  "$dest_dir" ]]; then
	log_error "Both -s <source_dir> and -d <dest_dir> are required!"
	usage >&2
	exit 2
fi

# Validation
[[ -d "$source_dir" ]] || die "Source directory '$source_dir' does not exist or is not a directory!" 1
[[ -r "$source_dir" ]] || die "No read permission for source directory '$source_dir'!" 1

mkdir -p "$dest_dir"     || die "Cannot create destination: $dest_dir"
[[ -w "$dest_dir" ]]       || die "Destination is not writable: $dest_dir"

timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
base_name=$(basename "$source_dir")
parent_dir=$(dirname "$source_dir")

if [[ "$compress" == true ]]; then
	archive_file="${dest_dir}/${base_name}_${timestamp}.tar.gz"
	tar_flags="-czf"
	log_info "Compression enabled (-c): creating gzipped archive..."

else 
	archive_file="${dest_dir}/${base_name}_${timestamp}.tar"
	tar_flags="-cf"
	log_info "Compression disabled: creating standard .tar archive..."
fi

tar "$tar_flags" "$archive_file" -C "$parent_dir" "$base_name" \  || die "tar failed to create archive!" 1
log_info "Backup successful, File: $archive_file"

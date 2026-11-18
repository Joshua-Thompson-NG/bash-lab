#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"

log_info "Starting application"
log_warn "Application is about to shutdown.."
log_error "Application crashes unexpetedly..."
log_info "Application is back up..."

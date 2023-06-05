#!/bin/bash
set -euo pipefail

main() {
    [[ "$#" -eq 0 ]] && usage
    local cmd=$1; shift
    case "$cmd" in
    cron) cron;;
    *) usage;;
    esac
}

usage() {
    cat <<EOF
Usage: $0 cron
EOF
    return 1
}

cron() {
    exec podman exec nextcloud-php php /usr/share/webapps/nextcloud/cron.php
}

main "$@"

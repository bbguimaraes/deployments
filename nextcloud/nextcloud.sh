#!/bin/bash
set -euo pipefail

DIR=/usr/share/webapps/nextcloud

main() {
    [[ "$#" -eq 0 ]] && usage
    local cmd=$1; shift
    case "$cmd" in
    cron) cmd cron.php "$@";;
    logs) logs "$@";;
    occ) cmd occ "$@";;
    upgrade) upgrade;;
    *) usage;;
    esac
}

usage() {
    cat <<EOF
Usage: $0 CMD ARGS...

Commands:

    cron ARGS...
    logs
    occ ARGS...
EOF
    return 1
}

cmd() {
    local cmd=$1; shift
    exec podman exec nextcloud-php \
        php-legacy "$DIR/$cmd" "$@"
}

upgrade() {
    cmd occ upgrade
    cmd occ db:add-missing-indices
    cmd occ maintenance:repair --include-expensive
}

logs() {
    podman exec nextcloud-php cat "$DIR/data/nextcloud.log"
}

main "$@"

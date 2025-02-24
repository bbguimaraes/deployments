#!/bin/bash
set -euo pipefail

main() {
    [[ "$#" -eq 0 ]] && usage
    local cmd=$1; shift
    case "$cmd" in
    cron) cmd cron.php "$@";;
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
    occ ARGS...
EOF
    return 1
}

cmd() {
    local cmd=$1; shift
    exec podman exec nextcloud-php \
        php-legacy "/usr/share/webapps/nextcloud/$cmd" "$@"
}

upgrade() {
    cmd occ upgrade
    cmd occ db:add-missing-indices
    cmd occ maintenance:repair --include-expensive
}

main "$@"

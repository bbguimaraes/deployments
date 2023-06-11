#!/bin/bash
set -euo pipefail

main() {
    [[ "$#" -eq 0 ]] && { start; return; }
    local cmd=$1; shift
    case "$cmd" in
    dumpall) dumpall "$@";;
    load) load "$@";;
    esac
}

usage() {
    cat >&2 <<EOF
Usage: $0 [dumpall|load]
EOF
    return 1
}

start() {
    local vol=/mnt/bbguimaraes1-vol/postgresql
    exec podman run \
        --name postgresql \
        --replace \
        --detach \
        --user 1000180000:users \
        --network nextcloud \
        --read-only \
        --tmpfs /run/postgresql \
        --volume "$vol:/var/lib/postgresql:Z" \
        postgresql
}

dumpall() {
    exec podman exec postgresql /usr/local/bin/wrapper.sh pg_dumpall
}

load() {
    exec podman exec --interactive postgresql /usr/local/bin/wrapper.sh psql
}

main "$@"

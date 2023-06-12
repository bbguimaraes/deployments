#!/bin/bash
set -euo pipefail

main() {
    [[ "$#" -eq 0 ]] && { cmd_start; return; }
    local cmd=$1; shift
    case "$cmd" in
    *) usage;;
    esac
}

usage() {
    cat <<EOF
Usage: $0 [CMD]
EOF
    return 1
}

cmd_start() {
    local vol=/mnt/bbguimaraes1-vol/synapse
    exec podman run \
        --name synapse \
        --replace \
        --detach \
        --user 1000100000:users \
        --network static \
        --read-only \
        --volume "$vol:/var/lib/synapse:Z" \
        synapse
}

main "$@"

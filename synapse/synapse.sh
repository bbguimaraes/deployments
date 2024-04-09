#!/bin/bash
set -euo pipefail

main() {
    [[ "$#" -eq 0 ]] && { cmd_start; return; }
    local cmd=$1; shift
    case "$cmd" in
    change-password) change_password "$@";;
    *) usage;;
    esac
}

usage() {
    cat <<EOF
Usage: $0 [CMD]

Commands:

    change-password USER
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
        synapse \
        "$@"
}

change_password() {
    [[ "$#" -ne 1 ]] && usage
    local user=$1
    exec podman exec --interactive --tty synapse bash -c "$(cat <<EOF
set -euo pipefail
h=\$(hash_password --config /var/lib/synapse/matrix.bbguimaraes.com.yaml)
sqlite3 \
    /var/lib/synapse/homeserver.db \
    "update users set password_hash = '\$h' where name == '$user';"
EOF
)"
}

main "$@"

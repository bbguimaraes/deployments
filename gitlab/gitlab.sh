#!/bin/bash
set -euo pipefail

main() {
    [[ "$#" -eq 0 ]] && usage
    local cmd=$1; shift
    case "$cmd" in
    bundle) bundle "$@";;
    *) usage;;
    esac
}

usage() {
    cat >&2 <<EOF
Usage: $0 CMD [ARGS...]

Commands:

    bundle ARGS...
EOF
    return 1
}

bundle() {
    exec podman exec gitlab-puma bundle-2.7 "$@"
}

main "$@"

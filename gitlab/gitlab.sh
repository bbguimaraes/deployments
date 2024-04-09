#!/bin/bash
set -euo pipefail

main() {
    [[ "$#" -eq 0 ]] && usage
    local cmd=$1; shift
    case "$cmd" in
    bundle) bundle "$@";;
    upgrade) upgrade "$@";;
    *) usage;;
    esac
}

usage() {
    cat >&2 <<EOF
Usage: $0 CMD [ARGS...]

Commands:

    bundle ARGS...
    upgrade
EOF
    return 1
}

bundle() {
    exec podman exec gitlab-puma bundle "$@"
}

upgrade() {
    bundle exec rake db:migrate:status RAILS_ENV=production "$@"
    bundle exec rake db:migrate RAILS_ENV=production "$@"
}

main "$@"

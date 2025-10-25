#!/bin/bash
set -euo pipefail

VOL=/mnt/bbguimaraes1-vol/mastodon

main() {
    [[ "$#" -eq 0 ]] && usage
    local cmd=$1; shift
    case "$cmd" in
    bundle) podman_exec bundle "$@";;
    configure) configure "$@";;
    rake) rake "$@";;
    tootctl) podman_exec env RAILS_ENV=production bin/tootctl "$@";;
    upgrade) upgrade "$@";;
    *) usage;;
    esac
}

usage() {
    cat >&2 <<EOF
Usage: $0 CMD [ARGS...]

Commands:

    bundle [ARGS...]
    configure
    rake [ARGS...]
    tootctl [ARGS...]
    upgrade
EOF
    return 1
}

podman_exec() {
    podman exec mastodon-puma "$@"
}

run() {
    podman run \
        --rm --interactive --tty \
        --user 1000160000:users \
        --network static \
        --read-only \
        --volume "$VOL/etc:/etc/mastodon:z" \
        --volume "$VOL/run:/run/mastodon:z" \
        --env LD_PRELOAD=libjemalloc.so \
        --env PORT=8000 \
        mastodon-puma \
        "$@"
}

configure() {
    rake mastodon:setup "$@"
}

rake() {
    run bundle exec rake RAILS_ENV=production "$@"
}

upgrade() {
    run bundle exec rails db:migrate RAILS_ENV=production "$@"
}

main "$@"

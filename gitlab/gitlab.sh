#!/bin/bash
set -euo pipefail

DIR=/usr/share/webapps/gitlab

main() {
    [[ "$#" -eq 0 ]] && usage
    local cmd=$1; shift
    case "$cmd" in
    bundle) bundle "$@";;
    check) check "$@";;
    logs) logs "$@";;
    upgrade) upgrade "$@";;
    *) usage;;
    esac
}

usage() {
    cat >&2 <<EOF
Usage: $0 CMD [ARGS...]

Commands:

    bundle ARGS...
    check
    logs
    upgrade
EOF
    return 1
}

bundle() {
    exec podman exec gitlab-puma bundle "$@"
}

check() {
    bundle exec rake gitlab:env:info RAILS_ENV=production
    bundle exec rake gitlab:check RAILS_ENV=production
}

logs() {
    exec podman exec gitlab-puma cat "$DIR/log/production.log"
}

upgrade() {
    bundle exec rake db:migrate:status RAILS_ENV=production "$@"
    bundle exec rake db:migrate RAILS_ENV=production "$@"
}

main "$@"

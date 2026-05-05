#!/bin/bash
set -euo pipefail

DIR=/usr/share/webapps/nextcloud

main() {
    [[ "$#" -eq 0 ]] && usage
    local cmd=$1; shift
    case "$cmd" in
    cron) cmd cron.php "$@";;
    logs) logs "$@";;
    news) news "$@";;
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
    news feed set-url ID LINK URL
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

news() {
    [[ "$#" -eq 0 ]] && usage
    local cmd=$1; shift
    case "$cmd" in
    feed) news_feed "$@";;
    *) usage;;
    esac
}

news_feed() {
    [[ "$#" -eq 0 ]] && usage
    local cmd=$1; shift
    case "$cmd" in
    set-url) news_feed_set_url "$@";;
    *) usage;;
    esac
}

news_feed_set_url() {
    [[ "$#" -eq 3 ]] || usage
    local id=$1 link=$2 url=$3
    "$(dirname "$BASH_SOURCE")/../postgresql/postgresql.sh" \
        psql nextcloud nextcloud --command "\
update oc_news_feeds
set
    link = '$link',
    url = '$url',
    location = '$url',
    url_hash = md5('$url')
where id = $id;
"
}

main "$@"

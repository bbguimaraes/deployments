#!/bin/sh
set -eu

. /usr/local/bin/wrapper_env.sh
if [ ! -e "$NSS_WRAPPER_PASSWD" ]; then
    grep -v ^postgres: /etc/passwd > "$NSS_WRAPPER_PASSWD"
    printf 'postgres:x:%s:%s:PostgreSQL user:%s:/bin/bash' \
        "$(id -u)" "$(id -g)" "$PGDATA" \
        >> "$NSS_WRAPPER_PASSWD"
fi
export NSS_WRAPPER_PASSWD NSS_WRAPPER_GROUP LD_PRELOAD
[ -e "$PGDATA" ] || initdb.sh
[ "$#" -gt 0 ] && exec "$@"
exec postgres

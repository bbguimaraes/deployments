#!/bin/bash
set -euo pipefail

docker network ls --format '{{.Name}}' \
    | grep --quiet --line-regexp static \
    || docker network create static
exec docker run \
    --name static \
    --detach \
    --user 1000140000:users \
    --network static \
    --read-only \
    --tmpfs /run/nginx:uid=1000140000 \
    --tmpfs /var/lib/nginx:uid=1000140000 \
    --volume /srv/nfs/bbguimaraes.com/bbguimaraes.com:/srv/http:Z \
    static

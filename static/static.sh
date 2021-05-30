#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/bbguimaraes.com/bbguimaraes.com
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
    --volume "$vol:/srv/http:Z" \
    static
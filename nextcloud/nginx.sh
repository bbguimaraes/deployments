#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/nextcloud
docker network ls --format '{{.Name}}' \
    | grep --quiet --line-regexp nextcloud \
    || docker network create nextcloud
exec docker run \
    --name nextcloud-nginx \
    --detach \
    --user 1000150000:users \
    --network nextcloud \
    --network-alias nginx \
    --read-only \
    --tmpfs /run/nginx:uid=1000140000 \
    --tmpfs /var/lib/nginx:uid=1000150000 \
    --volume "$vol/apps:/usr/share/webapps/nextcloud/apps:z" \
    --volume "$vol/data:/usr/share/webapps/nextcloud/data:z" \
    nextcloud-nginx

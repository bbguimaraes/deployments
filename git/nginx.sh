#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/git
docker network ls --format '{{.Name}}' \
    | grep --quiet --line-regexp git \
    || docker network create git
exec docker run \
    --name git-nginx \
    --detach \
    --user 1000130000:users \
    --network git \
    --read-only \
    --tmpfs /run/nginx \
    --tmpfs /var/lib/nginx \
    --volume "$vol:/srv/git:z" \
    git-nginx

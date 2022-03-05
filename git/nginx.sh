#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/git
exec podman run \
    --name git-nginx \
    --replace \
    --detach \
    --user 1000130000:users \
    --network git \
    --read-only \
    --tmpfs /run/nginx \
    --tmpfs /var/lib/nginx \
    --volume "$vol:/srv/git:z" \
    git-nginx

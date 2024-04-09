#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes1-vol/mastodon
exec podman run \
    --name mastodon-nginx \
    --replace \
    --detach \
    --user 1000160000:users \
    --network static \
    --read-only \
    --tmpfs /run/nginx \
    --tmpfs /var/cache/nginx \
    --tmpfs /var/lib/nginx \
    --volume "$vol/public:/var/lib/mastodon/public/system:z" \
    mastodon-nginx \
    "$@"

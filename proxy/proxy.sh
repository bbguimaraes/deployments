#!/bin/bash
set -euo pipefail

ssl_dir=/mnt/bbguimaraes0-vol/letsencrypt/etc/live/bbguimaraes.com
exec podman run \
    --name proxy \
    --detach \
    --network static \
    --publish 80:8000 \
    --publish 443:8443 \
    --publish 8448:8448 \
    --read-only \
    --tmpfs /run/nginx \
    --tmpfs /var/lib/nginx \
    --volume "$ssl_dir/fullchain.pem:/etc/nginx/ssl.crt:Z" \
    --volume "$ssl_dir/privkey.pem:/etc/nginx/ssl.key:Z" \
    proxy

#!/bin/bash
set -euo pipefail

ssl_dir=/srv/nfs/letsencrypt/etc/live/bbguimaraes.com
docker run \
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
for x in git synapse nextcloud gitlab; do
    docker network connect "$x" proxy
done

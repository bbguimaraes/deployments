#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/bbguimaraes.com/bbguimaraes.com
exec podman run \
    --name static \
    --detach \
    --user 1000140000:users \
    --network static \
    --read-only \
    --tmpfs /run/nginx \
    --tmpfs /var/lib/nginx \
    --volume "$vol:/srv/http:Z" \
    static

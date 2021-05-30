#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/nextcloud
exec podman run \
    --name nextcloud-php \
    --detach \
    --user 1000150000:users \
    --network nextcloud \
    --network-alias php \
    --read-only \
    --tmpfs /tmp \
    --volume "$vol/config:/etc/webapps/nextcloud/config:Z" \
    --volume "$vol/apps:/usr/share/webapps/nextcloud/apps:z" \
    --volume "$vol/data:/usr/share/webapps/nextcloud/data:z" \
    nextcloud-php

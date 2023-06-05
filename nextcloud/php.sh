#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes1-vol/nextcloud
exec podman run \
    --name nextcloud-php \
    --replace \
    --detach \
    --user 1000150000:users \
    --network nextcloud \
    --read-only \
    --tmpfs /tmp \
    --volume "$vol/config:/etc/webapps/nextcloud/config:Z" \
    --volume "$vol/apps:/usr/share/webapps/nextcloud/wapps:z" \
    --volume "$vol/data:/usr/share/webapps/nextcloud/data:z" \
    nextcloud-php

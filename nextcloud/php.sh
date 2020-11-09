#!/bin/bash
set -euo pipefail

docker network ls --format '{{.Name}}' \
    | grep --quiet --line-regexp nextcloud \
    || docker network create nextcloud
exec docker run \
    --name nextcloud-php \
    --detach \
    --user 1000150000:users \
    --network nextcloud \
    --network-alias php \
    --read-only \
    --tmpfs /tmp \
    --volume /srv/nfs/nextcloud/config:/etc/webapps/nextcloud/config:Z \
    --volume /srv/nfs/nextcloud/apps:/usr/share/webapps/nextcloud/apps:z \
    --volume /srv/nfs/nextcloud/data:/usr/share/webapps/nextcloud/data:z \
    nextcloud-php

#!/bin/bash
set -euo pipefail

docker run \
    --name postgresql \
    --detach \
    --user 1000180000:users \
    --network nextcloud \
    --read-only \
    --tmpfs /run/postgresql:uid=1000180000 \
    --volume /srv/nfs/postgresql:/var/lib/postgresql:Z \
    postgresql
docker network connect gitlab postgresql

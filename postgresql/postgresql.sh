#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/postgresql
exec podman run \
    --name postgresql \
    --detach \
    --user 1000180000:users \
    --network nextcloud \
    --read-only \
    --tmpfs /run/postgresql \
    --volume "$vol:/var/lib/postgresql:Z" \
    postgresql

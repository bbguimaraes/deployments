#!/bin/bash
set -euo pipefail

exec podman run \
    --name nextcloud-memcached \
    --replace \
    --detach \
    --user 1000150000:users \
    --network nextcloud \
    --read-only \
    nextcloud-memcached \
    "$@"

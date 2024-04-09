#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes1-vol/mastodon
exec podman run \
    --name mastodon-streaming \
    --replace \
    --detach \
    --user 1000160000:users \
    --network static \
    --read-only \
    --volume "$vol/etc:/etc/mastodon:z" \
    --env NODE_ENV=production \
    --env BIND=0.0.0.0 \
    --env PORT=8000 \
    --entrypoint node \
    mastodon-puma \
    ./streaming \
    "$@"

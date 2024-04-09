#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes1-vol/mastodon
exec podman run \
    --name mastodon-sidekiq \
    --replace \
    --detach \
    --stop-timeout 60 \
    --cgroup-conf memory.high=$((128 * 1024 * 1024)) \
    --memory-reservation 128m \
    --user 1000160000:users \
    --network static \
    --read-only \
    --tmpfs /tmp \
    --volume "$vol/etc:/etc/mastodon:z" \
    --volume "$vol/public:/var/lib/mastodon/public/system:z" \
    --entrypoint bundle \
    mastodon-puma \
    exec sidekiq \
    --environment production \
    --concurrency 3 \
    --config config/sidekiq.yml \
    "$@"

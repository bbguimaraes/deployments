#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes1-vol/gitlab
exec podman run \
    --name gitlab-sidekiq \
    --replace \
    --detach \
    --cgroup-conf memory.high=$((128 * 1024 * 1024)) \
    --memory-reservation 128m \
    --user 1000170000:users \
    --network gitlab \
    --read-only \
    --tmpfs /tmp \
    --tmpfs /var/log/gitlab \
    --volume "$vol/etc:/etc/webapps:z" \
    --entrypoint bundle-2.7 \
    gitlab-puma \
    exec sidekiq \
    --environment production \
    --concurrency 3 \
    --config config/sidekiq_queues.yml

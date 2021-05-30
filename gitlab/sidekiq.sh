#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/gitlab
docker network ls --format '{{.Name}}' \
    | grep --quiet --line-regexp gitlab \
    || docker network create gitlab
exec docker run \
    --name gitlab-sidekiq \
    --detach \
    --user 1000170000:users \
    --network gitlab \
    --network-alias sidekiq \
    --read-only \
    --tmpfs /tmp \
    --tmpfs /var/log/gitlab:uid=1000170000 \
    --volume "$vol/etc:/etc/webapps:z" \
    --entrypoint bundle \
    gitlab-puma \
    exec sidekiq \
    -e production \
    -C config/sidekiq_queues.yml

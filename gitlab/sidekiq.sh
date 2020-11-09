#!/bin/bash
set -euo pipefail

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
    --volume /srv/nfs/gitlab/etc:/etc/webapps:z \
    --entrypoint bundle \
    gitlab-puma \
    exec sidekiq \
    -e production \
    -C config/sidekiq_queues.yml

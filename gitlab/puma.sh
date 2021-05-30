#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/gitlab
docker network ls --format '{{.Name}}' \
    | grep --quiet --line-regexp gitlab \
    || docker network create gitlab
exec docker run \
    --name gitlab-puma \
    --detach \
    --user 1000170000:users \
    --network gitlab \
    --network-alias puma \
    --read-only \
    --tmpfs /tmp \
    --tmpfs /run/gitlab:uid=1000170000 \
    --tmpfs /var/log/gitlab:uid=1000170000 \
    --tmpfs /var/tmp \
    --volume "$vol/etc:/etc/webapps:z" \
    --volume "$vol/uploads:/var/lib/gitlab/uploads:z" \
    gitlab-puma

#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/gitlab
docker network ls --format '{{.Name}}' \
    | grep --quiet --line-regexp gitlab \
    || docker network create gitlab
exec docker run \
    --name gitlab-gitaly \
    --detach \
    --user 1000170000:users \
    --network gitlab \
    --network-alias gitaly \
    --read-only \
    --tmpfs /tmp \
    --tmpfs /var/log/gitlab \
    --volume "$vol/etc:/etc/webapps:z" \
    --volume "$vol/git:/var/lib/gitlab/repositories:z" \
    gitlab-gitaly

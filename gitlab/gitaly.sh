#!/bin/bash
set -euo pipefail

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
    --volume /srv/nfs/gitlab/etc:/etc/webapps:z \
    --volume /srv/nfs/gitlab/git:/var/lib/gitlab/repositories:z \
    gitlab-gitaly

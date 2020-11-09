#!/bin/bash
set -euo pipefail

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
    --volume /srv/nfs/gitlab/etc:/etc/webapps:z \
    --volume /srv/nfs/gitlab/uploads:/var/lib/gitlab/uploads:z \
    gitlab-puma

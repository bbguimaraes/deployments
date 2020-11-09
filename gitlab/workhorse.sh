#!/bin/bash
set -euo pipefail

docker network ls --format '{{.Name}}' \
    | grep --quiet --line-regexp gitlab \
    || docker network create gitlab
exec docker run \
    --name gitlab-workhorse \
    --detach \
    --user 1000170000:users \
    --network gitlab \
    --network-alias workhorse \
    --read-only \
    --volume /srv/nfs/gitlab/etc:/etc/webapps:z \
    --volume /srv/nfs/gitlab/uploads:/var/lib/gitlab/uploads:z \
    --entrypoint gitlab-workhorse \
    gitlab-puma \
    -listenAddr 0.0.0.0:8000 \
    -authBackend http://puma:8000 \
    -documentRoot /usr/share/webapps/gitlab/public

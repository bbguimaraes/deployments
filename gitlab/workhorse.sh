#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes1-vol/gitlab
exec podman run \
    --name gitlab-workhorse \
    --replace \
    --detach \
    --user 1000170000:users \
    --network gitlab \
    --read-only \
    --volume "$vol/etc:/etc/webapps:z" \
    --volume "$vol/uploads:/var/lib/gitlab/uploads:z" \
    --entrypoint gitlab-workhorse \
    gitlab-puma \
    -listenAddr 0.0.0.0:8000 \
    -authBackend http://gitlab-puma:8000 \
    -documentRoot /usr/share/webapps/gitlab/public \
    "$@"

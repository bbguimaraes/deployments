#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/gitlab
exec podman run \
    --name gitlab-workhorse \
    --detach \
    --user 1000170000:users \
    --network gitlab \
    --network-alias workhorse \
    --read-only \
    --volume "$vol/etc:/etc/webapps:z" \
    --volume "$vol/uploads:/var/lib/gitlab/uploads:z" \
    --entrypoint gitlab-workhorse \
    gitlab-puma \
    -listenAddr 0.0.0.0:8000 \
    -authBackend http://puma:8000 \
    -documentRoot /usr/share/webapps/gitlab/public

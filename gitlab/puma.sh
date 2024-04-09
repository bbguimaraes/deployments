#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes1-vol/gitlab
exec podman run \
    --name gitlab-puma \
    --replace \
    --detach \
    --stop-timeout 60 \
    --user 1000170000:users \
    --network gitlab \
    --read-only \
    --tmpfs /tmp \
    --tmpfs /run/gitlab \
    --tmpfs /var/log/gitlab \
    --tmpfs /var/tmp \
    --volume "$vol/etc:/etc/webapps:z" \
    --volume "$vol/uploads:/var/lib/gitlab/uploads:z" \
    gitlab-puma \
    "$@"

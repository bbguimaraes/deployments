#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes1-vol/gitlab
exec podman run \
    --name gitlab-gitaly \
    --replace \
    --detach \
    --user 1000170000:users \
    --network gitlab \
    --read-only \
    --tmpfs /tmp \
    --tmpfs /var/log/gitlab \
    --volume "$vol/etc:/etc/webapps:z" \
    --volume "$vol/git:/var/lib/gitlab/repositories:z" \
    gitlab-gitaly \
    "$@"

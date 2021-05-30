#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/gitlab
exec podman run \
    --name gitlab-puma \
    --detach \
    --user 1000170000:users \
    --network gitlab \
    --network-alias puma \
    --read-only \
    --tmpfs /tmp \
    --tmpfs /run/gitlab \
    --tmpfs /var/log/gitlab \
    --tmpfs /var/tmp \
    --volume "$vol/etc:/etc/webapps:z" \
    --volume "$vol/uploads:/var/lib/gitlab/uploads:z" \
    gitlab-puma

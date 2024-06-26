#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes1-vol/git
exec podman run \
    --name git-uwsgi \
    --replace \
    --detach \
    --user 1000130000:users \
    --network git \
    --read-only \
    --volume "$vol:/srv/git:z" \
    git-uwsgi \
    "$@"

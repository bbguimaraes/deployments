#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/git
docker network ls --format '{{.Name}}' \
    | grep --quiet --line-regexp git \
    || docker network create git
exec docker run \
    --name git-uwsgi \
    --detach \
    --user 1000130000:users \
    --network git \
    --read-only \
    --volume "$vol:/srv/git:z" \
    git-uwsgi

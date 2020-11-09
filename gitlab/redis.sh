#!/bin/bash
set -euo pipefail

docker network ls --format '{{.Name}}' \
    | grep --quiet --line-regexp gitlab \
    || docker network create gitlab
exec docker run \
    --name gitlab-redis \
    --detach \
    --user 1000170000:users \
    --network gitlab \
    --network-alias redis \
    --read-only \
    gitlab-redis \
    --protected-mode no

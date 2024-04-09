#!/bin/bash
set -euo pipefail

exec podman run \
    --name gitlab-redis \
    --replace \
    --detach \
    --user 1000170000:users \
    --network gitlab \
    --read-only \
    gitlab-redis \
    /etc/redis/redis.conf \
    --protected-mode no \
    "$@"

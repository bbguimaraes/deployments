#!/bin/bash
set -euo pipefail

exec podman run \
    --name gitlab-redis \
    --replace \
    --detach \
    --user 1000170000:users \
    --network gitlab \
    --network-alias redis \
    --read-only \
    gitlab-redis \
    /etc/redis/redis.conf \
    --protected-mode no

#!/bin/bash
set -euo pipefail

exec docker run \
    --name gitlab-redis \
    --detach \
    --user 1000170000:users \
    --network gitlab \
    --network-alias redis \
    --read-only \
    gitlab-redis \
    --protected-mode no

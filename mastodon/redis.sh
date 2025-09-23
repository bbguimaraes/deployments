
#!/bin/bash
set -euo pipefail

exec podman run \
    --name mastodon-redis \
    --replace \
    --detach \
    --user 1000160000:users \
    --network static \
    --read-only \
    gitlab-redis \
    /etc/valkey/valkey.conf \
    --protected-mode no \
    "$@"

#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes1-vol/mastodon
exec podman run \
    --name mastodon-puma \
    --replace \
    --detach \
    --stop-timeout 60 \
    --user 1000160000:users \
    --network static \
    --read-only \
    --volume "$vol/etc:/etc/mastodon:z" \
    --volume "$vol/public:/var/lib/mastodon/public/system:z" \
    --volume "$vol/run:/run/mastodon:z" \
    --env BIND=0.0.0.0 \
    --env PORT=8000 \
    mastodon-puma \
    bundle exec puma -C config/puma.rb

#    --env LD_PRELOAD=libjemalloc.so \
#    --workdir /run/mastodon \
#    --tmpfs /tmp \
#    --tmpfs /run/gitlab \
#    --tmpfs /var/log/gitlab \
#    --tmpfs /var/tmp \
#    --volume "$vol/uploads:/var/lib/gitlab/uploads:z" \

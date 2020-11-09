#!/bin/bash
set -euo pipefail

docker network ls --format '{{.Name}}' \
    | grep --quiet --line-regexp nextcloud \
    || docker network create nextcloud
exec docker run \
    --name nextcloud-memcached \
    --detach \
    --user 1000150000:users \
    --network nextcloud \
    --network-alias memcached \
    --read-only \
    nextcloud-memcached

#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/synapse
docker network ls --format '{{.Name}}' \
    | grep --quiet --line-regexp synapse \
    || docker network create synapse
exec docker run \
    --name synapse \
    --detach \
    --user 1000100000:users \
    --network synapse \
    --read-only \
    --volume "$vol:/var/lib/synapse:Z" \
    synapse

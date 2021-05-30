#!/bin/bash
set -euo pipefail

vol=/mnt/bbguimaraes0-vol/synapse
exec podman run \
    --name synapse \
    --detach \
    --user 1000100000:users \
    --network synapse \
    --read-only \
    --volume "$vol:/var/lib/synapse:Z" \
    synapse

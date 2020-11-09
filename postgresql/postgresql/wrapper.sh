#!/bin/bash
set -eu

. /usr/local/bin/wrapper_env.sh
export NSS_WRAPPER_PASSWD NSS_WRAPPER_GROUP LD_PRELOAD
exec "$@"

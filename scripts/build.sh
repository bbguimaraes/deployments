#!/bin/bash
set -euo pipefail

podman build -t proxy proxy/nginx/
podman build -t static static/nginx/
podman build -t synapse synapse/synapse/
podman build -t git-nginx git/nginx/
podman build -t git-uwsgi git/uwsgi/
podman build -t postgresql-postgresql postgresql/postgresql/
podman build -t nextcloud-memcached nextcloud/memcached/
podman build -t nextcloud-nginx nextcloud/nginx/
podman build -t nextcloud-php nextcloud/php/
podman build -t gitlab-gitaly gitlab/gitaly/
podman build -t gitlab-puma gitlab/puma/
podman build -t gitlab-redis gitlab/redis/

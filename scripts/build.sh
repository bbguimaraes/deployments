#!/bin/bash
set -euo pipefail

docker build -t proxy proxy/nginx/
docker build -t static static/nginx/
docker build -t synapse synapse/synapse/
docker build -t git-nginx git/nginx/
docker build -t git-uwsgi git/uwsgi/
docker build -t postgresql-postgresql postgresql/postgresql/
docker build -t nextcloud-memcached nextcloud/memcached/
docker build -t nextcloud-nginx nextcloud/nginx/
docker build -t nextcloud-php nextcloud/php/
docker build -t gitlab-gitaly gitlab/gitaly/
docker build -t gitlab-puma gitlab/puma/
docker build -t gitlab-redis gitlab/redis/

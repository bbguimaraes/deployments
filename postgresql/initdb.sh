#!/bin/sh
set -eu

initdb --locale en_US.UTF-8 --encoding UTF8
echo "listen_addresses = '*'" >> "$PGDATA/postgresql.conf"
echo 'host all all 0.0.0.0/0 trust' >> "$PGDATA/pg_hba.conf"

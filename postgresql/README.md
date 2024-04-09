postgresql
==========

Upgrading major versions.

    $ postgresql/postgresql.sh dumpall > db.sql
    $ scripts/build.lua postgresql
    $ mv /path/to/data /path/to/data.old
    $ scripts/deploy.lua postgresql
    $ postgresql/postgresql.sh load < db.sql

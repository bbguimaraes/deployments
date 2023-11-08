mastodon
========

Build images.

    # scripts/build.lua mastodon

In case of EMFILE when building `mastodon-puma`:

    # podman build -t mastodon-puma --ulimit nofile=8192 puma/

Create database user.

    # podman exec postgresql createuser --createdb mastodon

Deploy.

    # scripts/deploy.lua mastodon

Set up.

    # mastodon/mastodon.sh bundle \
        exec rails mastodon:setup \
        RAILS_ENV=production NODE_OPTIONS=--openssl-legacy-provider

gitlab
======

Upgrade
-------

https://docs.gitlab.com/ee/update/upgrading_from_source.html

Build the new images.

    # scripts/build.lua gitlab

Restart containers.

    # scripts/deploy.lua gitlab

Execute upgrade command.

    # podman exec gitlab-puma \
        bundle exec rake db:migrate:status RAILS_ENV=production
    # podman exec gitlab-puma \
        bundle exec rake db:migrate RAILS_ENV=production

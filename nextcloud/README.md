nextcloud
=========

Upgrade
-------

https://docs.nextcloud.com/server/latest/admin_manual/maintenance/upgrade.html

Build the new images.

    # scripts/build.lua nextcloud

Restart containers.

    # scripts/deploy.lua nextcloud

Execute upgrade command.

    # podman exec nextcloud-php php /usr/share/webaps/occ upgrade

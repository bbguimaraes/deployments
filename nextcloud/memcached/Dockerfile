FROM arch
ENTRYPOINT ["/usr/bin/memcached"]
EXPOSE 11211
RUN pacman --dbpath /var/lib/pacman --noconfirm -Syu memcached

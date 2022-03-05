FROM arch
ENTRYPOINT ["/bin/redis-server"]
EXPOSE 6379
RUN pacman --dbpath /var/lib/pacman --noconfirm -Syu redis \
    && sed -i \
        -e '/^bind /s/^/#/' -e '/^dir /s/^/#/' -e '$asave ""' \
        /etc/redis/redis.conf

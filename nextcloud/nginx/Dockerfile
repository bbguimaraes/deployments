FROM arch
RUN pacman --dbpath /var/lib/pacman --noconfirm -Syu nextcloud
EXPOSE 8000
ENTRYPOINT ["/usr/bin/nginx"]
RUN pacman --dbpath /var/lib/pacman --noconfirm -Syu nginx \
    && rm -r /var/lib/nginx
COPY nginx.conf /etc/nginx/

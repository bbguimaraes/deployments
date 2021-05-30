FROM arch
RUN pacman --noconfirm -Syu nextcloud
EXPOSE 8000
ENTRYPOINT ["/usr/bin/nginx"]
RUN pacman --noconfirm -Syu nginx \
    && rm -r /var/lib/nginx
COPY nginx.conf /etc/nginx/

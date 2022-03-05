FROM arch
ENTRYPOINT ["/usr/bin/nginx"]
RUN pacman --dbpath /var/lib/pacman --noconfirm -Syu nginx \
    && rm -r /var/lib/nginx
EXPOSE 8000 8443 8448
COPY nginx.conf /etc/nginx/

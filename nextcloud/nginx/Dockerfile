FROM arch
RUN pacman --noconfirm -Syu nextcloud
EXPOSE 8000
ENTRYPOINT ["/usr/bin/nginx"]
RUN pacman --noconfirm -Syu nginx
COPY nginx.conf /etc/nginx/

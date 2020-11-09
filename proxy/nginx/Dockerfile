FROM arch
ENTRYPOINT ["/usr/bin/nginx"]
RUN pacman --noconfirm -Syu nginx
EXPOSE 8000 8443 8448
COPY nginx.conf /etc/nginx/

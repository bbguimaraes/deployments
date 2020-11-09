FROM arch
ENTRYPOINT ["/usr/bin/nginx"]
RUN pacman --noconfirm -Syu nginx
EXPOSE 8000
COPY nginx.conf /etc/nginx/

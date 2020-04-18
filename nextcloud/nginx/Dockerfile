FROM arch
RUN pacman --noconfirm -Syu nextcloud
EXPOSE 8000
ENTRYPOINT ["/usr/bin/nginx"]
RUN pacman --noconfirm -Syu nginx
RUN for x in 'mkdir -p' 'chown :root' 'chmod g+w'; do \
        $x /run/nginx /var/lib/nginx/{client-body,fastcgi,proxy,scgi,uwsgi}; \
    done
USER http
COPY nginx.conf /etc/nginx/

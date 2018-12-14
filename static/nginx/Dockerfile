FROM arch
ENTRYPOINT ["/usr/bin/nginx"]
EXPOSE 8000
RUN pacman --noconfirm -Syu nginx && pacman --noconfirm -Sc
RUN for x in 'mkdir -p' 'chown :root' 'chmod g+w'; do \
        $x /run/nginx /var/lib/nginx/{client-body,fastcgi,proxy,scgi,uwsgi}; \
    done
USER http
COPY nginx.conf /etc/nginx/

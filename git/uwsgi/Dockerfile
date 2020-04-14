FROM arch
ENTRYPOINT ["/usr/bin/uwsgi"]
CMD ["/etc/uwsgi.ini"]
EXPOSE 8000
RUN pacman --noconfirm -Syu git uwsgi uwsgi-plugin-cgi
USER http
COPY uwsgi.ini /etc/uwsgi.ini

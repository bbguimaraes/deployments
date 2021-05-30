FROM arch
EXPOSE 8000
WORKDIR /usr/share/webapps/gitlab
RUN pacman --noconfirm -Syu gitlab
ENTRYPOINT [ \
    "bundle-2.7", "exec", "puma", \
    "-C", "config/puma.rb", "-e", "production"]
ENV RAILS_ENV=production EXECJS_RUNTIME=Disabled
RUN pacman --noconfirm -Syu ruby-pg yarn \
    && rm -r \
        /run/gitlab \
        /usr/share/webapps/gitlab/public/uploads \
        /var/log/gitlab \
        /var/tmp

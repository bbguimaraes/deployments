FROM arch
EXPOSE 8000
WORKDIR /usr/share/webapps/gitlab
RUN pacman --noconfirm -Syu gitlab
ENTRYPOINT [ \
    "bundle", "exec", "puma", \
    "-C", "config/puma.rb", "-e", "production"]
ENV RAILS_ENV=production EXECJS_RUNTIME=Disabled
RUN pacman --noconfirm -Syu ruby-pg yarn

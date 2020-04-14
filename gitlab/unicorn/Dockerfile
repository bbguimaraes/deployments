FROM arch
EXPOSE 8000
WORKDIR /usr/share/webapps/gitlab
RUN pacman --noconfirm -Syu gitlab
ENTRYPOINT [ \
    "bundle", "exec", "unicorn_rails", \
    "-c", "config/unicorn.rb", "-E", "production"]
RUN pacman --noconfirm -Syu ruby-pg yarn \
    && rm /usr/share/webapps/gitlab/db/schema.rb \
    && ln -s \
        /etc/webapps/gitlab/schema.rb \
        /usr/share/webapps/gitlab/db/schema.rb

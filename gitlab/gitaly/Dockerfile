FROM arch
EXPOSE 8000
WORKDIR /usr/share/webapps/gitlab
RUN pacman --noconfirm -Syu gitlab
ENTRYPOINT ["gitaly", "/etc/gitlab-gitaly/config.toml"]
RUN chmod o+rx /var/lib/gitlab \
    && ln -sf \
        /etc/webapps/gitlab-gitaly/config.toml \
        /etc/gitlab-gitaly/config.toml

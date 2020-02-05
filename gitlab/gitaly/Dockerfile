FROM arch
EXPOSE 8000
WORKDIR /usr/share/webapps/gitlab
ENTRYPOINT ["gitaly", "/etc/gitlab-gitaly/config.toml"]
RUN pacman --noconfirm -Syu gitlab \
    && pacman --noconfirm -Sc \
    && chmod o+rx /var/lib/gitlab \
    && sed -i /etc/gitlab-gitaly/config.toml \
        -e '/^socket_path =/a listen_addr = "0.0.0.0:8000"' \
        -e '/^socket_path =/s/^/#/'

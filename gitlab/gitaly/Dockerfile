FROM arch
EXPOSE 8000
WORKDIR /usr/share/webapps/gitlab
ENTRYPOINT [ \
    "/usr/local/bin/entrypoint.sh", \
    "gitaly", "/etc/gitlab-gitaly/config.toml"]
RUN pacman --noconfirm -Syu gitlab \
    && pacman --noconfirm -Sc \
    && printf > /usr/local/bin/entrypoint.sh \
        '#!/bin/sh\nPATH=$PATH:/opt/ruby2.5/bin exec "$@"' \
    && chmod 755 /usr/local/bin/entrypoint.sh \
    && chmod o+rx /var/lib/gitlab \
    && sed -i /etc/gitlab-gitaly/config.toml \
        -e '/^socket_path =/a listen_addr = "0.0.0.0:8000"' \
        -e '/^socket_path =/s/^/#/'

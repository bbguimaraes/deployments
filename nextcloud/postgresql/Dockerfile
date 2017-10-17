FROM arch
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
ENV PGDATA=/var/lib/postgresql/data
RUN sed -i '/^#en_US.UTF-8/s/^#//' /etc/locale.gen \
    && locale-gen \
    && pacman --noconfirm -Syu postgresql
COPY build_nss_wrapper.sh /usr/local/bin/
RUN build_nss_wrapper.sh
USER postgres
COPY entrypoint.sh wrapper.sh wrapper_env.sh initdb.sh /usr/local/bin/

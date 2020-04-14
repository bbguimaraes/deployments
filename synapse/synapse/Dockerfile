# python-lxml python-netaddr are required for link previews.
FROM arch
ENTRYPOINT [ \
    "python", "-B", "-m", \
    "synapse.app.homeserver", "-c", "matrix.yaml"]
WORKDIR /var/lib/synapse
RUN pacman --noconfirm -Syu matrix-synapse python-lxml python-netaddr

FROM arch
RUN pacman --noconfirm -Syu nextcloud
EXPOSE 8000
ENTRYPOINT ["/usr/bin/php-fpm"]
RUN sed -i '/^#en_US.UTF-8/s/^#//' /etc/locale.gen \
    && locale-gen \
    && pacman --noconfirm -Syu \
        php-apcu php-fpm php-gd php-imagick php-intl php-memcached php-pgsql \
    && rm /etc/php/php-fpm.d/www.conf
COPY php.ini /etc/php/conf.d/
COPY php-fpm.conf /etc/php/php-fpm.d/

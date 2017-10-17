FROM arch
ENTRYPOINT ["/usr/bin/php-fpm"]
EXPOSE 8000
RUN sed -i '/^#en_US.UTF-8/s/^#//' /etc/locale.gen \
    && locale-gen \
    && pacman --noconfirm -Syu \
        php-fpm php-gd php-pgsql php-apcu php-memcached \
    && rm /etc/php/php-fpm.d/www.conf
COPY php.ini /etc/php/conf.d/
COPY php-fpm.conf /etc/php/php-fpm.d/

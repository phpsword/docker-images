FROM williarin/php:8.1-fpm-dev

RUN set -eux; \
    wget -O cachetool https://gordalina.github.io/cachetool/downloads/cachetool-8.4.1.phar; \
    chmod +x cachetool; \
    mv cachetool /usr/local/bin/cachetool; \
    apk update; \
    apk add --no-cache \
        sudo \
        less \
        mysql-client \
        rsync \
        ghostscript \
        imagemagick \
        php81-pear \
        php81-bcmath \
        php81-mysqli \
        php81-exif \
        php81-session \
        php81-pecl-imagick \
    ; \
    apk add --no-cache --virtual .build-deps autoconf re2c gcc make g++ zlib-dev php81-dev; \
    pear81 update-channels; \
    pecl81 update-channels; \
    pecl81 install --onlyreqdeps --nobuild redis; \
    pecl81 install igbinary; \
    cd "$(pecl81 config-get temp_dir)/redis"; \
    phpize81; \
    ./configure --enable-redis-igbinary --with-php-config=/usr/bin/php-config81; \
    echo "extension=igbinary" > /etc/php81/conf.d/00_igbinary.ini; \
    echo "extension=redis" > /etc/php81/conf.d/03_redis.ini; \
    make && make install; \
    apk del .build-deps;

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN find /tmp -type d -exec chmod -v 1777 {} +

WORKDIR /var/www/html

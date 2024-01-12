FROM williarin/php:8.2-fpm-dev

ARG TARGETPLATFORM
ENV TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}

RUN set -eux; \
    wget -O cachetool https://github.com/gordalina/cachetool/releases/latest/download/cachetool.phar; \
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
        php82-pear \
        php82-bcmath \
        php82-mysqli \
        php82-exif \
        php82-session \
        php82-pecl-imagick \
    ; \
    if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        apk add --no-cache --virtual .build-deps autoconf re2c gcc make g++ zlib-dev php82-dev; \
        pear82 update-channels; \
        pecl82 update-channels; \
        pecl82 install --onlyreqdeps --nobuild redis-5.3.7; \
        pecl82 install igbinary; \
        cd "$(pecl82 config-get temp_dir)/redis"; \
        phpize82; \
        ./configure --enable-redis-igbinary --with-php-config=/usr/bin/php-config82; \
        echo "extension=igbinary" > /etc/php82/conf.d/00_igbinary.ini; \
        echo "extension=redis" > /etc/php82/conf.d/03_redis.ini; \
        make && make install; \
        apk del .build-deps; \
    else \
        apk add --no-cache php82-pecl-igbinary php82-pecl-redis; \
    fi

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN find /tmp -type d -exec chmod -v 1777 {} +

WORKDIR /var/www/html

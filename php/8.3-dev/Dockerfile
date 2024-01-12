FROM williarin/php:8.3-fpm-dev

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
        imagemagick; \
    apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
        php83-pear \
        php83-bcmath \
        php83-mysqli \
        php83-exif \
        php83-session \
        php83-pecl-imagick \
    ; \
    if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        apk add --no-cache \
            --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
            --repository=https://dl-cdn.alpinelinux.org/alpine/3.19/main \
            --virtual .build-deps autoconf re2c gcc make g++ zlib-dev php83-dev; \
        pear83 update-channels; \
        pecl83 update-channels; \
        pecl83 install --onlyreqdeps --nobuild redis-5.3.7; \
        pecl83 install igbinary; \
        cd "$(pecl83 config-get temp_dir)/redis"; \
        phpize83; \
        ./configure --enable-redis-igbinary --with-php-config=/usr/bin/php-config83; \
        echo "extension=igbinary" > /etc/php83/conf.d/00_igbinary.ini; \
        echo "extension=redis" > /etc/php83/conf.d/03_redis.ini; \
        make && make install; \
        apk del .build-deps; \
    else \
        apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community php83-pecl-igbinary php83-pecl-redis; \
    fi

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN find /tmp -type d -exec chmod -v 1777 {} +

WORKDIR /var/www/html

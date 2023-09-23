FROM williarin/php:8.1-fpm

ARG TARGETPLATFORM
ENV TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}

RUN set -eux; \
    wget -O cachetool https://gordalina.github.io/cachetool/downloads/cachetool.phar; \
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
    if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        apk add --no-cache --virtual .build-deps autoconf re2c gcc make g++ zlib-dev php81-dev; \
        pear81 update-channels; \
        pecl81 update-channels; \
        pecl81 install --onlyreqdeps --nobuild redis-5.3.7; \
        pecl81 install igbinary; \
        cd "$(pecl81 config-get temp_dir)/redis"; \
        phpize81; \
        ./configure --enable-redis-igbinary --with-php-config=/usr/bin/php-config81; \
        echo "extension=igbinary" > /etc/php81/conf.d/00_igbinary.ini; \
        echo "extension=redis" > /etc/php81/conf.d/03_redis.ini; \
        make && make install; \
        apk del .build-deps; \
    else \
        apk add --no-cache php81-pecl-igbinary php81-pecl-redis; \
    fi

WORKDIR /var/www/html

FROM alpine:latest

ENV TZ="Asia/Shanghai"
ENV USER=www
ENV GROUP=www
ENV PM_MAX_CHILDREN=10

RUN addgroup -g 82 -S www && \
    adduser -u 82 -D -S -G www www && \
    apk add --no-cache tzdata curl ca-certificates \
    php7 \
    php7-bcmath \
    php7-brotli \
    php7-bz2 \
    php7-common \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-exif \
    php7-fileinfo \
    php7-fpm \
    php7-gd \
    php7-gettext \
    php7-gmp \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mcrypt \
    php7-mysqli \
    php7-mysqlnd \
    php7-opcache \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-pdo_sqlite \
    php7-pecl-igbinary \
    php7-pecl-imagick \
    php7-pecl-memcached \
    php7-pecl-msgpack \
    php7-pecl-redis \
    php7-phar \
    php7-posix \
    php7-session \
    php7-shmop \
    php7-simplexml \
    php7-soap \
    php7-sockets \
    php7-sodium \
    php7-sqlite3 \
    php7-sysvmsg \
    php7-sysvsem \
    php7-sysvshm \
    php7-tokenizer \
    php7-wddx \
    php7-xml \
    php7-xmlreader \
    php7-xmlrpc \
    php7-xmlwriter \
    php7-xsl \
    php7-zip \
    php7-zlib

RUN curl -sS https://getcomposer.org/installer | \
    php7 -- --install-dir=/usr/bin --filename=composer && \
    sed -i "s|;daemonize = yes|daemonize = no|g" /etc/php7/php-fpm.conf && \
    sed -i "s|user = nobody|user = ${USER}|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i "s|group = nobody|group = ${GROUP}|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i "s|pm.max_children =.*|pm.max_children = ${PM_MAX_CHILDREN}|g" /etc/php7/php-fpm.d/www.conf && \
    rm -rf /var/cache/apk/*

EXPOSE 9000
CMD ["php-fpm7"]
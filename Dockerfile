FROM php:7.3-alpine

COPY --from=composer:1.9 /usr/bin/composer /usr/bin/composer

RUN apk update && \
    apk --no-cache add bash libmcrypt-dev libxml2-dev libzip-dev mysql-client postgresql-dev freetype-dev libjpeg-turbo-dev libpng-dev icu-dev alpine-sdk autoconf nodejs nodejs-npm yarn python2 python && \
    rm -rf /usr/local/etc/php-fpm.d/* && \
    rm -rf /etc/nginx/conf.d && \
    docker-php-ext-install soap zip pdo_mysql pgsql pdo_pgsql mbstring gd xml bcmath intl

ENTRYPOINT /bin/bash

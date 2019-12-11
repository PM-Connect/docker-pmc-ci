FROM php:7.3-alpine

ARG PHPREDIS_VERSION='5.0.2'

COPY --from=composer:1.9 /usr/bin/composer /usr/bin/composer

ENV PHPREDIS_VERSION=$PHPREDIS_VERSION

RUN apk update && \
    apk --no-cache add bash libmcrypt-dev libxml2-dev libzip-dev mysql-client postgresql-dev freetype-dev libjpeg-turbo-dev libpng-dev icu-dev alpine-sdk autoconf nodejs nodejs-npm yarn python2 python docker && \
	apk -Uuv add make gcc groff less \
		musl-dev libffi-dev openssl-dev \
		python2-dev py-pip && \
	pip install awscli docker-compose && \
	rm /var/cache/apk/*    rm -rf /usr/local/etc/php-fpm.d/* && \
	rc-update add docker boot && \
    rm -rf /etc/nginx/conf.d && \
    curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz && \
    tar -xzf /tmp/redis.tar.gz -C /tmp && \
    rm -r /tmp/redis.tar.gz && \
    mkdir -p /usr/src/php/ext && \
    mv /tmp/phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis && \
    docker-php-ext-install soap zip pdo_mysql pgsql pdo_pgsql mbstring gd xml bcmath intl opcache redis

ENTRYPOINT /bin/bash

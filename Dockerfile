FROM php:7.2-alpine

RUN apk update && \
    apk --no-cache add bash libmcrypt-dev libxml2-dev libzip-dev mysql-client postgresql-dev freetype-dev libjpeg-turbo-dev libpng-dev icu-dev alpine-sdk autoconf nodejs nodejs-npm yarn && \
    rm -rf /usr/local/etc/php-fpm.d/* && \
    rm -rf /etc/nginx/conf.d && \
    docker-php-ext-install soap zip pdo_mysql pgsql pdo_pgsql mbstring gd xml bcmath intl && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

ENTRYPOINT /bin/bash

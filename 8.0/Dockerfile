# -------------------------------------------------------------
# @Generated Pá čen 19 11:00:02 CEST 2020
#
# Don't edit this file directly!
# For edit use Docker file in root directory & run ./copy.sh
# to regenerate
# -------------------------------------------------------------

FROM php:8.0-fpm

RUN set -e && \
	apt-get update && apt-get install --no-install-recommends -y \
		wget \
		rsyslog \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        ssh \
        git \
        telnet \
        unzip \
        openssl \
        libzip-dev \
        libxml2 \
        zlib1g-dev \
        nodejs \
		curl \
		gnupg2 \
		apt-transport-https \
		npm \
	&& rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_mysql mysqli zip bcmath

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update \
 && apt-get install -y yarn

# Webpack globally
RUN npm install -g webpack

# -----------------------------------------------
# Composer
# -----------------------------------------------

RUN EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig) \
    ; php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    ; ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');") \
    ; [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ] && echo 'ERROR: Invalid installer signature' && exit 1 \
	; php composer-setup.php --quiet \
	; mv composer.phar /usr/local/bin/composer \
	; chmod +x /usr/local/bin/composer \
	; RESULT=$? \
	; rm composer-setup.php \
	; echo $RESULT \
	; exit $RESULT

RUN set -e && composer --version

# -----------------------------------------------
# XDebug
# -----------------------------------------------

RUN echo "Install xDebug ..." \
    && yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    || true

# -----------------------------------------------
# igbinary
# -----------------------------------------------

RUN pecl install igbinary && docker-php-ext-enable igbinary

# -----------------------------------------------
# Redis
# -----------------------------------------------

RUN set -e \
	&& pecl install redis \
	&& docker-php-ext-enable redis


# -----------------------------------------------
# Soap
# -----------------------------------------------


RUN set -e && \
    	apt-get update && apt-get install --no-install-recommends -y \
            libxml2-dev \
    	&& rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install soap

# -----------------------------------------------
# Sentry CLI
# -----------------------------------------------

RUN curl -sL https://sentry.io/get-cli/ | bash && sentry-cli --help


# -----------------------------------------------
# CI Coverage
# -----------------------------------------------

RUN pecl install pcov

# -----------------------------------------------
# etc.
# -----------------------------------------------

LABEL maintener="lukas@klima.dev"


WORKDIR /var/docker

RUN rm -rf /var/lib/apt/lists/*

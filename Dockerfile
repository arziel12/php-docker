
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
        zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_mysql mysqli zip bcmath

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
	; exit $RESULT

# -----------------------------------------------
# XDebug
# -----------------------------------------------

RUN echo "Install xDebug ..." \
    && yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

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
# etc.
# -----------------------------------------------

LABEL maintener="arziel12@gmail.com"
WORKDIR /var/docker

RUN rm -rf /var/lib/apt/lists/*

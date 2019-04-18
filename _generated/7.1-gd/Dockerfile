
FROM arziel/php:7.1

RUN set -e && \
    apt-get update && apt-get install -yqq \
		git \
		zlib1g-dev \
		libpng-dev \
		libwebp-dev \
		libjpeg-dev


RUN docker-php-ext-configure gd \
    	    --enable-gd-native-ttf \
    	    --with-jpeg-dir=/usr/lib/x86_64-linux-gnu \
    	    --with-png-dir=/usr/lib/x86_64-linux-gnu \
    	    --with-freetype-dir=/usr/lib/x86_64-linux-gnu \
    	    --with-webp-dir=/usr/lib/x86_64-linux-gnu \
    	&& docker-php-ext-install gd

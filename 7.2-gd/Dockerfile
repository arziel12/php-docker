
FROM arziel/php:7.2

RUN docker-php-ext-configure gd \
    	    --enable-gd-native-ttf \
    	    --with-jpeg-dir=/usr/lib/x86_64-linux-gnu \
    	    --with-png-dir=/usr/lib/x86_64-linux-gnu \
    	    --with-freetype-dir=/usr/lib/x86_64-linux-gnu \
    	&& docker-php-ext-install gd

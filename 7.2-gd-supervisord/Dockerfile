
FROM arziel/php:7.2

ENV DEBIAN_FRONTEND noninteractive

RUN set -e && \
	apt-get update && apt-get install --no-install-recommends -y \
		supervisord


CMD ["/usr/local/bin/supervisord"]


RUN rm -rf /var/lib/apt/lists/*


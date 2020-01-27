#!/usr/bin/env bash

mkdir -p out

./generate.sh

_b() {
	docker build $1 --tag arziel/php:$1 > out/$1.log
}

#
#_b 7.2 &&  _b 7.2-gd \
 _b 7.3 &&  _b 7.3-gd
#& _b 7.4 &&  _b 7.4-gd \
#& wait
#


set -e


docker build 7.4 --tag arziel/php:7.4 --no-cache
docker build 7.4-gd --tag arziel/php:7.4-gd


docker build dotykacka --tag arziel/php:dotykacka


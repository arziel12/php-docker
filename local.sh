#!/usr/bin/env bash


_b() {
	docker build $1 --tag arziel/php:$1
}

_b 7.1 \
& _b 7.2 \
& _b 7.3 \
& _b 7.1-gd \
& _b 7.2-gd \
& _b 7.3-& gd \
& wait

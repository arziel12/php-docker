#!/usr/bin/env bash

_cp() {
		echo "# -------------------------------------------------------------"
		echo "# @Generated $(date)"
		echo "#"
		echo "# Don't edit this file directly!"
		echo "# For edit use Docker file in root directory & run ./copy.sh"
		echo "# to regenerate"
		echo "# -------------------------------------------------------------"
}

_generate() {
	mkdir -p $1
	FROM=$2

	if [[ $FROM == "" ]]; then
		FROM=$1
	fi

	echo "Copy $1"
	{
		_cp;echo
		echo FROM php:$FROM
		cat ./Dockerfile
	} > $1/Dockerfile
}

_gd() {
	mkdir -p $2
	{
		_cp; echo
		echo FROM arziel/php:$1
		cat ./gd.Dockerfile
	} > $2/Dockerfile
}

#_generate 7.2 7.2-fpm
_generate 7.3 7.3-fpm
_generate 7.4 7.4-fpm

#_gd 7.2 7.2-gd
_gd 7.3 7.3-gd
_gd 7.4 7.4-gd

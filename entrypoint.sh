#! /bin/sh -e

[[ "$DEBUG" == "true" ]] && set -x

exec "$@"


#!/usr/bin/with-contenv bash

umask 022

exec \
	s6-setuidgid abc python /app/sickrage/SickBeard.py \
    --datadir /config
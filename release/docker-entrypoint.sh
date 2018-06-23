#!/bin/sh

# WORKDIR will only get set to /kiwiirc if WORKDIR isn't already set
: ${WORKDIR:=/kiwiirc}

if [ -f ${WORKDIR}-data/config.conf ]; then
	ln -sf ${WORKDIR}-data/config.conf
elif [ -d ${WORKDIR}-data/ ]; then
	cp config.conf.example ${WORKDIR}-data/config.conf
	ln -sf ${WORKDIR}-data/config.conf
else
	cp config.conf.sample config.conf
fi

if [ -f ${WORKDIR}-data/config.json ]; then
	(cd www/static; ln -sf ${WORKDIR}-data/config.json)
elif [ -d ${WORKDIR}-data ]; then
	cp www/static/config.json ${WORKDIR}-data
	(cd www/static; ln -sf ${WORKDIR}-data/config.json)
fi

exec "$@"

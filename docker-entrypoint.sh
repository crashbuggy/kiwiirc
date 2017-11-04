#!/bin/sh

if [ -f /kiwiirc-data/config.conf ]; then
	ln -sf /kiwiirc-data/config.conf
elif [ -d /kiwiirc-data/ ]; then
	cp config.conf.example /kiwiirc-data/config.conf
	ln -sf /kiwiirc-data/config.conf
else
	cp config.conf.sample config.conf
fi

if [ -f /kiwiirc-data/config.json ]; then
	(cd www/static; ln -sf /kiwiirc-data/config.json)
elif [ -d /kiwiirc-data ]; then
	cp www/static/config.json /kiwiirc-data
	(cd www/static; ln -sf /kiwiirc-data/config.json)
fi

exec "$@"

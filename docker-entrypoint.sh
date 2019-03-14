#!/bin/sh

# if you bind mount a file on eg /etc/kiwiirc/config.json, it will be used as the config, 
# same as /etc/kiwiirc/config.conf, otherwise it will use the volume kiwiirc-data
# to store the two config files.

if [ -f /etc/kiwiirc/config.json ]; then
	CONFIG_JSON=/etc/kiwiirc/config.json
else
	CONFIG_JSON="/kiwiirc-data/config.json"
	if [ ! -f "$CONFIG_JSON" ]; then
		cp /kiwiirc/www/static/config.json "$CONFIG_JSON"
	fi
fi

if [ -f /etc/kiwiirc/config.conf ]; then
	CONFIG_CONF=/etc/kiwiirc/config.conf
else
	CONFIG_CONF="/kiwiirc-data/config.conf"
	if [ ! -f "$CONFIG_CONF" ]; then
		cp /kiwiirc/config.conf.example "$CONFIG_CONF"
	fi
fi

(cd /kiwiirc && ln -sf "$CONFIG_CONF")
(cd /kiwiirc/www/static && ln -sf "$CONFIG_JSON")

# you can bind mount shell scripts in /docker-entrypoint.d to run your own customisation on run
# eg /docker-entrypoint/99-custom.sh will be sourced
if [ -d /docker-entrypoint.d ]; then
	for SCRIPT in /docker-entrypoint.d/*.sh; do
		. "$SCRIPT"
	done
fi

exec "$@"


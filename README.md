# kiwiirc
kiwiirc

If you run something like

```
docker run --rm --mount source=kiwiirc-data,target=/kiwiirc-data crashbuggy/kiwiirc false
```
You'll end up with a volume called wikiirc-data with 2 files in it

config.conf
config.json

If you're not sure where the volume is, run

```
docker inspect kiwiirc-data`
```

You'll find it at the Mountpoint, mine is

``"Mountpoint": "/var/lib/docker/volumes/kiwiirc-data/_data",`


You can edit those as per the documentation found in https://github.com/kiwiirc/kiwiirc and
https://github.com/kiwiirc/webircgateway

Then you can rerun the docker like

```
docker run --rm --mount source=kiwiirc-data,target=/kiwiirc-data crashbuggy/kiwiirc
```

When searching for docs or solutions, just be careful the post or docs you're reading are for
the current version.

I'll add some nginx docs soon.
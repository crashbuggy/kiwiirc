# kiwiirc

Unofficial kiwiirc image.

crashbuggy/kiwiirc:latest-git will track the dev branch.

crashbuggy/kiwiirc:latest will track the releases, so far there has been one release which was over a year ago.


There are two ways to manage the config files. The original way, if you run something like

```
docker run --rm --mount source=kiwiirc-data,target=/kiwiirc-data crashbuggy/kiwiirc false
```
You'll end up with a persistent volume called kiwiirc-data with 2 files in it

config.conf
config.json

You can edit those as per the documentation found in https://github.com/kiwiirc/kiwiirc and
https://github.com/kiwiirc/webircgateway

Then you can rerun the docker like

```
docker run --rm --mount source=kiwiirc-data,target=/kiwiirc-data crashbuggy/kiwiirc
```

The newer way for this image which I now prefer, you need to get the config files out of the docker image by running:
```.env
docker run --rm crashbuggy/kiwiirc:latest-git cat config.conf.example > etc/config.conf
docker run --rm crashbuggy/kiwiirc:latest-git cat www/static/config.json > etc/config.json
```

After editing you can bind mount them in /etc/kiwiirc/. There's an example docker-compose.yml included in this repo. 

When searching for docs or solutions, just be careful the post or docs you're reading are for
the current version.


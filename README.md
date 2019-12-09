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
## Better way to get started ##
The newer way for this image which I now prefer, you need to get the config files out of the docker image by running:
```.env
docker run --rm crashbuggy/kiwiirc:latest-git cat config.conf.example > etc/config.conf
docker run --rm crashbuggy/kiwiirc:latest-git cat www/static/config.json > etc/config.json
```

After editing you can bind mount them in /etc/kiwiirc/. There's an example docker-compose.yml included in this repo. 

When searching for docs or solutions, just be careful the post or docs you're reading are for
the current version.

## Next steps (TLS) ##
This image does a basic install of KiwiIRC inside the docker container.

If you follow the above steps, you'll end up with KiwiIRC's default `config.conf` and `config.json` files. These are intended to be run as normal processes and need a bit of poking to get them to work inside a docker container. 

To get up and running:

1. Make sure you enable file serving in `config.conf`. It's optional for normal KiwiIRC installations, but not in this case., otherwise the container won't be able to serve the client code.
2. The `kiwiirc` executable runs in the container as a non-root user. If you want SSL/TLS to work, you must use a port over 1024 on the container (e.g. use port 8081 instead of 443). You can map it to whatever port you want on the host, e.g in `config.conf`:
```
# Example TLS server
[server.2]
bind = "0.0.0.0"
port = 8081
tls = true
cert = /path/to/your/cert.pem
key = /path/to/your/privkey.pem
```
and in `docker-compose.yml`:
```
  kiwiirc:
    image: crashbuggy/kiwiirc:latest-git
    ports:
      - 8080:8080
      - 8081:8081
```
3. If you're using TLS, you must make sure that the config.json sets the kiwiserver value to point to the same port that you're running the service on, otherwise you'll be making an illegal request from a secure to a non-secure resource, and the browser is likely to prevent this. For example, if you're running the service on the host as 192.168.0.1:8081, in `config.json`:
 ```
 "kiwiServer": "https://192.168.0.1:8081/webirc/kiwiirc/"
 ```

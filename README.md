# docker-node

[![](https://images.microbadger.com/badges/version/iheartradio/node.svg)]
[![](https://images.microbadger.com/badges/image/iheartradio/node.svg)]

iHeartRadio's Nodejs Dockerfiles

## Maintaining

To deploy everything:

```
make all n=4.4.7 b=1
```

Where:

* `n` is the Node version
* `b` is the build number for this Node version

A build number should never be re-used/overwritten after it has been published and has started to be used.

## TODO

- update Node build script (see official node Dockerfile using secure signature)
- move image to Alpine Linux, pin base OS version/digest pin?
- pin dependencies
- setup auto builds -- once https://github.com/docker/hub-feedback/issues/292 is resolved
- describe features
- add shrinkwrap support
- update workdir/src dir
- add example usage Dockerfile and build command
- run as non-root user?

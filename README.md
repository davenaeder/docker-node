# docker-node

[![](https://images.microbadger.com/badges/version/iheartradio/node.svg)](http://microbadger.com/images/iheartradio/node "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/iheartradio/node.svg)](http://microbadger.com/images/iheartradio/node "Get your own image badge on microbadger.com")

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

- use gpg to verify signature in Node build script, see: https://github.com/nodejs/docker-node/blob/master/4.5/Dockerfile
- add shrinkwrap support
- update workdir/src dir
- setup auto builds -- once https://github.com/docker/hub-feedback/issues/292 is resolved
- pin system package dependencies? -- once we have autobuilds
- add node_modules cache support? -- https://lincolnloop.com/blog/speeding-npm-installs/
- move image to Alpine Linux, pin base OS version, possilby use digest pin -- once ruby dependency is gone
- run as non-root user? -- interesting so can avoid --unsafe-perm with npm, look into Docker user namespaces
- doc work:
  - describe features
  - add example usage Dockerfile and build command

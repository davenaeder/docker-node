# docker-node

[![](https://images.microbadger.com/badges/version/iheartradio/node.svg)](http://microbadger.com/images/iheartradio/node "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/iheartradio/node.svg)](http://microbadger.com/images/iheartradio/node "Get your own image badge on microbadger.com")

iHeartRadio's Nodejs Dockerfiles

## Description

This repository provides a base image for running Nodejs, as well as an onbuild image and examples to package an application that depends on modules hosted on private git repositories in a secure way using ssh-agent.

## Usage

### bootstrapping

Use the [pre-install Dockefile](example/preinstall.Dockerfile) example to build your pre-install image from the onbuild image:

```bash
docker build -f preinstall.Dockerfile -t company/app-preinstall .
PREINSTALL_ID=`docker images --no-trunc | awk '$1 == "company/app-preinstall"' | awk '{print $3}'`
```

### npm install

A `docker run` step and [docker-ssh-agent-forward](https://github.com/avsm/docker-ssh-agent-forward) are required to perform an `npm install` depending on private repositories hosted on Github. Bellow is a sample script:

```bash
docker run `pinata-ssh-mount` -v $HOME/.ssh/known_hosts:/root/.ssh/known_hosts:ro --name app-install-container company/app-preinstall install
docker commit app-install-container company/app-install:$PREINSTALL_ID
docker rm app-install-container
```

To cache this step, simply bypass it if you already have the install image with the ID corresponding to your preinstall ID:

```bash
if [ $(docker images | awk '$1 == "company/app-install"' | awk '$2 == "$PREINSTALL_ID"' | wc -l) -eq 0 ]; then
  # make app-install image
fi
```

### wrapping up

A post-install Dockerfile example completing the bundling the source code of your app is provided in [example/postinstall.Dockerfile](example/postinstall.Dockerfile). Simply sed' in the install ID to complete your build:

```bash
sed 's/PREINSTALL_ID/$PREINSTALL_ID/g' postinstall.Dockerfile > postinstall.Dockerfile.versioned
docker build -f postinstall.Dockerfile.versioned -t company/app-postinstall .
```

## Maintenance

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
- move image to Alpine Linux, pin base OS version, possilby use digest pin
- run as non-root user? -- interesting so can avoid --unsafe-perm with npm, look into Docker user namespaces
- add git tagging in release to ensure repo versions an be matched to published images
- document production usage? copying artifacts, tagging intermediary images and containers with hashes

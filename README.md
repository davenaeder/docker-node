# docker-node

iHeartRadio's Nodejs Dockerfiles

## Maintaining

To deploy everything:

```
make all n=4.4.7 b=1
```

Where:

* `n` is the Node version
* `b` is the build number for this Node version

A build number should never not be re-used/overwritten after it has been published and has started to be used.

## TODO

- move image to Alpine Linux
- update Node build script
- describe features, add Docker status badge
- add shrinkwrap support
- update workdir/src dir
- add example usage Dockerfile and build command
- if doing automated builds, should pin dependencies

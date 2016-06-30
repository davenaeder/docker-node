# docker-node
iHeartRadio's Nodejs Dockerfiles

## Maintaining

### Base node image

```
docker build -t tarikihr/node4-lts:latest .
docker tag tarikihr/node4-lts:latest tarikihr/node4-lts:4.4.7
docker push tarikihr/node4-lts:latest
docker push tarikihr/node4-lts:4.4.7
```

### Onbuild image

```
cd onbuild
docker build -t tarikihr/node4-lts:onbuild .
docker tag tarikihr/node4-lts:onbuild tarikihr/node4-lts:4.4.7-onbuild
docker push tarikihr/node4-lts:onbuild
docker push tarikihr/node4-lts:4.4.7-onbuild
```

### TODO

- add shrinkwrap support
- update workdir/src dir
- add example usage Dockerfile and build command
- use `mv` instead of `cp` for `node_modules` or remove usage of tmp by incremential install
- remove #2 prepublish after symlink dependency is also removed
- update Node build script
- move image to Alpine Linux

# docker-node
iHeartRadio's Nodejs Dockerfiles

## Maintaining

### Base node image

```
docker build -t tarikihr/node4-lts:latest .
docker tag tarikihr/node4-lts:latest tarikihr/node4-lts:4.2.6
docker push tarikihr/node4-lts:latest
docker push tarikihr/node4-lts:4.2.6
```

### Onbuild image

```
cd onbuild
docker build -t tarikihr/node4-lts:onbuild .
docker tag tarikihr/node4-lts:onbuild tarikihr/node4-lts:4.2.6-onbuild
docker push tarikihr/node4-lts:onbuild
docker push tarikihr/node4-lts:4.2.6-onbuild
```

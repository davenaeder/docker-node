FROM debian:jessie

MAINTAINER Tarik Ansari "TarikAnsari@iheartmedia.com"

ARG NODE_VERSION

# Install system packages
RUN \
  apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    xz-utils && \
  rm -rf /var/lib/apt/lists/*

# Install Node.js (modified from: https://github.com/nodejs/docker-node/blob/master/4.5/Dockerfile)
RUN \
  curl -SL "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" | \
    tar -xJf - -C /usr/local --strip-components=1

ENTRYPOINT ["node"]

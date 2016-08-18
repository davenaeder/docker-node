FROM debian:jessie

MAINTAINER Tarik Ansari "TarikAnsari@iheartmedia.com"

ARG NODE_VERSION
ARG NODE_TAG=v$NODE_VERSION

# Install system packages
RUN \
  apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    --no-install-recommends

# Clear apt cache
RUN  rm -rf /var/lib/apt/lists/*

# Install Node.js (modified from: https://github.com/dockerfile/nodejs/blob/master/Dockerfile)
RUN \
  curl -SL https://nodejs.org/dist/$NODE_TAG/node-$NODE_TAG-linux-x64.tar.gz -o /tmp/node.tar.gz && \
  cd /usr/local && tar --strip-components 1 -xzf /tmp/node.tar.gz && \
  rm /tmp/node.tar.gz && \
  printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc

ENTRYPOINT ["node"]

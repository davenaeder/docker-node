# other known issues:
# * UTF-8 to US-ASCII conversion when installing sass

FROM debian:jessie

MAINTAINER Tarik Ansari "TarikAnsari@iheartmedia.com"

ENV NODE_VERSION v4.2.6
ENV NPM_VERSION  2.14.18

# Install system packages
# compass install requires ruby, ruby-dev, make and ruby-ffi
# git provides support for npm git packages
# openssh-client provides support for ssh-keyscan and git+ssh
RUN \
  apt-get update && apt-get install -y \
    ca-certificates \
    openssh-client \
    git \
    ruby ruby-dev ruby-ffi make \
    curl \
    --no-install-recommends

# Install Node.js (modified from: https://github.com/dockerfile/nodejs/blob/master/Dockerfile)
RUN \
  curl -SL https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.gz -o /tmp/node.tar.gz && \
  cd /usr/local && tar --strip-components 1 -xzf /tmp/node.tar.gz && \
  rm /tmp/node.tar.gz && \
  npm install -g npm@$NPM_VERSION && \
  printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc


# Install Ruby system packages
RUN \
  apt-get update && apt-get install -y \
    ruby ruby-dev ruby-ffi make \
    --no-install-recommends

# Clear apt cache
RUN  rm -rf /var/lib/apt/lists/*

# Install Ruby-based tools
RUN \
  gem install --no-rdoc --no-ri \
    compass:1.0.3 \
    compass-rgbapng:0.2.1


CMD ["node"]

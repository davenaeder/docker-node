FROM iheartradio/node:NODE_VERSION

# Install system packages
RUN \
  apt-get update && apt-get install -y --no-install-recommends \
    # git provides support for npm git packages
    git \
    # openssh-client provides git+ssh support for private repositories
    openssh-client && \
  rm -rf /var/lib/apt/lists/*

# this path for backward compatibility
ONBUILD WORKDIR /data/apps/web

# Build module separately so that Docker can cache them when code changes
# see: http://bitjudo.com/blog/2014/03/13/building-efficient-dockerfiles-node-dot-js/
ONBUILD COPY package.json ./

# install step is done in a docker run image to allow usage of ssh-agent
# pre-create the .ssh/ directory to allow mounting of known_hosts file on Linux
ONBUILD RUN mkdir -p /root/.ssh

ENTRYPOINT ["npm"]

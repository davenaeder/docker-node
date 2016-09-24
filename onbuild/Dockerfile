FROM iheartradio/node:NODE_VERSION

# Install system packages
RUN \
  apt-get update && apt-get install -y --no-install-recommends \
    # git provides support for npm git packages
    git \
    # openssh-client provides support for ssh-keyscan and git+ssh for private repositories
    openssh-client && \
  rm -rf /var/lib/apt/lists/*

# setup git SSH key for private repos access (npm packages on github)
ONBUILD COPY id_rsa /root/.ssh/
ONBUILD RUN \
  # fix for Windows issue copying key with access rights too open
  chmod 600 /root/.ssh/id_rsa && \
  ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts

# this path for backward compatibility
ONBUILD WORKDIR /data/apps/web

# Build module separately so that Docker can cache them when code changes
# see: http://bitjudo.com/blog/2014/03/13/building-efficient-dockerfiles-node-dot-js/
ONBUILD COPY package.json ./
# copy configs for vendor/postinstall build, avoidable if vendor builds are pre-packaged
# NOTE: COPY fails here if using short form copy (COPY config/vendoring config/)
ONBUILD COPY config/vendoring/ config/vendoring/
# unsafe-perm required for postinstall script since running npm as root
# TODO: could run vendoring separately instead
ONBUILD RUN npm install --unsafe-perm

# remove private SSH key
ONBUILD RUN rm /root/.ssh/id_rsa

# Bundle app source
ONBUILD COPY . .

ENTRYPOINT ["npm", "run"]

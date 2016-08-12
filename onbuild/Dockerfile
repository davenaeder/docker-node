FROM tarikihr/node4-lts:4.4.7

# setup git SSH key for private repos access (npm packages on github)
ONBUILD RUN mkdir -p /root/.ssh
ONBUILD COPY id_rsa /root/.ssh/
ONBUILD RUN \
  # fix for Windows issue copying key with access rights too open
  chmod 600 /root/.ssh/id_rsa && \
  ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts

# elaborate path for backward compatibility
ONBUILD WORKDIR /data/apps/web

# Build module separately so that Docker can cache them when code changes
# see: http://bitjudo.com/blog/2014/03/13/building-efficient-dockerfiles-node-dot-js/
ONBUILD COPY package.json ./
# TODO: change to copy generic vendoring configs for postinstall script, or pre-package vendor builds
ONBUILD COPY modernizr-config.json ./
# unsafe-perm required for postinstall script since running npm as root
ONBUILD RUN npm install --unsafe-perm

# remove private SSH key
ONBUILD RUN rm /root/.ssh/id_rsa

# Bundle app source
ONBUILD COPY . .

# Build app assets
ONBUILD RUN npm run build

ENTRYPOINT ["npm", "run"]
CMD ["start"]

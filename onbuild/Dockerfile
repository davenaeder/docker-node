FROM tarikihr/node4-lts:4.2.6

ARG GITHUB_KEY

# setup git SSH key for private repos access (npm packages on github)
ONBUILD RUN \
  mkdir -p /root/.ssh && \
  (umask 077; echo "$GITHUB_KEY" > /root/.ssh/id_rsa) && \
  ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts

# Build module separately so that Docker can cache them when code changes
# see: http://bitjudo.com/blog/2014/03/13/building-efficient-dockerfiles-node-dot-js/
ONBUILD COPY package.json /tmp/
ONBUILD RUN cd /tmp && npm install

# remove private SSH key
ONBUILD RUN rm /root/.ssh/id_rsa

# Bundle app source
ONBUILD WORKDIR /data/apps/web
ONBUILD COPY . .

# Copy app dependencies
ONBUILD RUN cp -a /tmp/node_modules ./
ONBUILD RUN npm run prepublish # run a second time so it runs locally for symbolic link


# Build app assets
ONBUILD RUN npm run build

CMD ["npm", "start"]

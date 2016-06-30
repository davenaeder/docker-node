FROM tarikihr/node4-lts:4.2.6

# setup git SSH key for private repos access (npm packages on github)
ONBUILD RUN mkdir -p /root/.ssh
ONBUILD COPY id_rsa /root/.ssh/
ONBUILD RUN chmod 600 ~/.ssh/id_rsa # fix for Windows issue copying key with access rights too open
ONBUILD RUN ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts

# Build module separately so that Docker can cache them when code changes
# see: http://bitjudo.com/blog/2014/03/13/building-efficient-dockerfiles-node-dot-js/
ONBUILD COPY package.json /tmp/
ONBUILD RUN cd /tmp && npm install

# Bundle app source
ONBUILD WORKDIR /data/apps/web
ONBUILD COPY . .

# Copy app dependencies
ONBUILD RUN cp -a /tmp/node_modules ./
ONBUILD RUN npm run prepublish # run a second time so it runs locally for symbolic link

# remove private SSH key
ONBUILD RUN rm /root/.ssh/id_rsa

# Build app assets
ONBUILD RUN npm run build

CMD ["npm", "start"]

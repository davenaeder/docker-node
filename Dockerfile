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
    --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

# Install Ruby-based tools
RUN \
  gem install --no-rdoc --no-ri \
    compass:1.0.3 \
    compass-rgbapng:0.2.1

# Install Node.js (modified from: https://github.com/dockerfile/nodejs/blob/master/Dockerfile)
RUN \
  curl -SL https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.gz -o /tmp/node.tar.gz && \
  cd /usr/local && tar --strip-components 1 -xzf /tmp/node.tar.gz && \
  rm /tmp/node.tar.gz && \
  npm install -g npm@$NPM_VERSION && \
  printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc

# setup git SSH key for private repos access (npm packages on github)
RUN mkdir -p /root/.ssh
COPY id_rsa /root/.ssh/
RUN chmod 600 ~/.ssh/id_rsa # fix for Windows issue copying key with access rights too open
RUN ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts

# Build module separately so that Docker can cache them when code changes
# see: http://bitjudo.com/blog/2014/03/13/building-efficient-dockerfiles-node-dot-js/
COPY package.json /tmp/
RUN cd /tmp && npm install

# Bundle app source
WORKDIR /data/apps/web
COPY . .

# Copy app dependencies
RUN cp -a /tmp/node_modules ./
RUN npm run prepublish # run a second time so it runs locally for symbolic link

# remove private SSH key
RUN rm /root/.ssh/id_rsa

# Build app assets
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]

FROM debian:11

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
  apt-get install -y --no-install-recommends \
      alsa-utils \
      libsndfile1-dev \
      ca-certificates \
      curl \
      git \
      python-is-python2

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
      autoconf automake bzip2 dpkg-dev file g++ gcc imagemagick libbz2-dev libc6-dev libcurl4-openssl-dev libdb-dev libevent-dev libffi-dev libgdbm-dev libgeoip-dev libglib2.0-dev libjpeg-dev libkrb5-dev liblzma-dev libmagickcore-dev libmagickwand-dev libncurses5-dev libncursesw5-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libtool libwebp-dev libxml2-dev libxslt-dev libyaml-dev make patch xz-utils zlib1g-dev

ARG NODE_VERSION=9.8.0
ARG TARGETPLATFORM
RUN case ${TARGETPLATFORM} in \
     "linux/amd64")  NODE_ARCH=x64  ;; \
     "linux/arm64")  NODE_ARCH=arm64  ;; \
     "linux/arm/v7") NODE_ARCH=armv7l  ;; \
     "linux/arm/v6") NODE_ARCH=armv6l  ;; \
    esac \
 && NODE_PACKAGE=node-v$NODE_VERSION-linux-$NODE_ARCH \
 && curl https://nodejs.org/dist/v$NODE_VERSION/$NODE_PACKAGE.tar.gz \
 | tar -xz -C /usr/local --strip-components=1  --no-same-owner \
 && ln -s /usr/local/bin/node /usr/local/bin/nodejs

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY app .

EXPOSE 3000
CMD [ "node", "index.js" ]

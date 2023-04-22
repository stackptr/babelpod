FROM buildpack-deps:bullseye AS base

ENV DEBIAN_FRONTEND noninteractive

RUN groupadd --gid 1000 node && useradd --uid 1000 --gid node --shell /bin/bash --create-home node

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

FROM node:9.8 AS builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY app .

FROM base

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app .

RUN apt-get update -y && \
  apt-get install -y --no-install-recommends \
      alsa-utils \
      libsndfile1-dev \
      python-is-python2

RUN usermod -a -G audio node

USER node

EXPOSE 3000
CMD [ "node", "index.js" ]

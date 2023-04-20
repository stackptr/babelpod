FROM debian:11

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
  apt-get install -y --no-install-recommends \
      alsa-utils \
      libsndfile1-dev \
      ca-certificates \
      curl

ARG NODE_VERSION=v9.8.0
ARG TARGETPLATFORM
RUN case ${TARGETPLATFORM} in \
     "linux/amd64")  NODE_ARCH=x64  ;; \
     "linux/arm64")  NODE_ARCH=arm64  ;; \
     "linux/arm/v7") NODE_ARCH=armv7l  ;; \
     "linux/arm/v6") NODE_ARCH=armv6l  ;; \
    esac \
 && NODE_PACKAGE=node-$NODE_VERSION-linux-$NODE_ARCH \
 && curl https://nodejs.org/dist/$NODE_VERSION/$NODE_PACKAGE.tar.gz | tar -xz -C /opt \
 && mv /opt/node-* /opt/node

ENV NODE_HOME=/opt/node
ENV NODE_PATH /opt/node/lib/node_modules
ENV PATH /opt/node/bin:$PATH

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY app .

EXPOSE 3000
CMD [ "node", "index.js" ]

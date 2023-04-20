FROM node:9.8

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
  apt-get install -y --no-install-recommends \
      alsa-base \
      alsa-utils \
      libsndfile1-dev && \
  apt-get clean

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY app .

EXPOSE 3000
CMD [ "node", "index.js" ]

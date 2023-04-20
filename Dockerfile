FROM debian:11

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
  apt-get install -y --no-install-recommends \
      alsa-utils \
      libsndfile1-dev \
      ca-certificates \
      curl

RUN curl -fsSL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY app .

EXPOSE 3000
CMD [ "node", "index.js" ]

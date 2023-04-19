FROM node:9.8

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY app .

EXPOSE 3001
CMD [ "node", "index.js" ]

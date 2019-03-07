FROM node:10-alpine

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

# COPY package*.json ./

USER node

RUN npm install --save express
RUN npm install ejs --save
RUN npm install body-parser --save
RUN npm install request

COPY --chown=node:node . .

EXPOSE 8080

CMD [ "node", "server.js" ]

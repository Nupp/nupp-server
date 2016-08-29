FROM node:6.3.1

RUN useradd --user-group --create-home --shell /bin/false nupp && \
    apt-get clean

ENV HOME=/home/nupp

COPY code/package.json code/npm-shrinkwrap.json $HOME/nupp-server/

RUN chown -R nupp:nupp $HOME/*

USER nupp
WORKDIR $HOME/nupp-server
RUN npm cache clean && \
    npm i nsp requiresafe -g && \
    nsp check && \
    npm i nodemon helmet letsencrypt-express --save --silent && \
    npm install --silent --progress=false

USER root
COPY code/ $HOME/nupp-server
RUN chown -R nupp:nupp $HOME/*
USER nupp

CMD ["node_modules/.bin/nodemon", "server.js"]

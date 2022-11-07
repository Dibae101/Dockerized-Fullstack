FROM node:6.2.0

LABEL maintainer="Dibya Darshan Khanal"

ENV HOME=/usr/app

RUN mkdir -p $HOME

WORKDIR $HOME

COPY package.json ./

RUN npm install --global yarn --force

RUN yarn install

COPY . .

EXPOSE 8000

CMD ["yarn", "start"]

#Frontend build
FROM node:latest as builder

LABEL maintainer="Dibya Darshan Khanal"

WORKDIR '/app'

# for legacy Angular
COPY boss.yml .

COPY bower.json .

COPY Gruntfile.js .

COPY typings.json .

COPY webpack.config.js .

COPY .bowerrc .

RUN npm i grunt-cli --location=global

# install bower
RUN npm install bower --location=global

RUN bower install --allow-root --verbose --force

# Npm packages

COPY package.json .

RUN npm install --legacy-peer-deps

COPY . .

RUN npm run dev
# CMD ["npm", "run", "dev"]

# # nginx
FROM nginx:alpine
 
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app/public /usr/share/nginx/html
# runs in docker inspect IP at 80 port by default
# # use latest lts node

# docker build -t new-frontend -f frontend.dockerfile .

# docker run -v /home/darshan/Desktop/kwant/webapi:/app -dp 80:80 new-frontend

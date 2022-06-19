#Frontend build
FROM node:latest as builder

LABEL maintainer="Dibya Darshan Khanal"

WORKDIR '/app'

COPY boss.yml .

COPY bower.json .

COPY Gruntfile.js .

COPY typings.json .

COPY webpack.config.js .

COPY package.json .

COPY constants.js .

COPY .yo-rc.json .

COPY .eslintrc .

COPY .bowerrc .

COPY .v8flags-1-5.1.281.111.63a9f0ea7bb98050796b649e85481845.json .

COPY .snyk .

COPY .babelrc .

COPY .editorconfig .

# install bower
RUN npm install bower --location=global 

RUN bower install --legacy-peer-deps --force

RUN bower install ngHandsontable --save --force

RUN npm i grunt-cli --location=global

# Npm packages

COPY package.json .

COPY .env .

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

# docker run -dp 80:80 new-frontend

# docker system prune -a // remove cache

# detach mode: docker run -p 80:80 --rm --name frontend-app <docker_image>

# docker network create ontarget-net
# docker run --name frontend --rm -d --network ontarget-net new-frontend



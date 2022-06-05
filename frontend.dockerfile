#Frontend build
FROM node:latest as builder
 
LABEL maintainer="Dibya Darshan Khanal"
 
WORKDIR /app
 
#COPY package.json .
 
COPY . /app
 
# install bower
 
RUN npm install --global bower
 
# Install bower packages
RUN bower install --allow-root
 
RUN npm install --legacy-peer-deps
 
RUN npm run dev
 
# CMD ["npm", "run", "dev"]
 
# # nginx
FROM nginx:alpine
 

COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/public /usr/share/nginx/html
 
 
# runs in docker inspect IP at 80 port by default
 
 
# # use latest lts node
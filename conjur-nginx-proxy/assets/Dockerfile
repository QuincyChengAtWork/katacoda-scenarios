FROM nginx:1.13.6-alpine

WORKDIR /etc/nginx

COPY default.conf /etc/nginx/conf.d/
COPY tls/nginx.key ./
COPY tls/nginx.crt ./

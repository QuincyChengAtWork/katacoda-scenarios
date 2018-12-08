FROM nginx:1.15.7-alpine

WORKDIR /etc/nginx

COPY default.conf /etc/nginx/conf.d/
COPY tls/nginx.key ./
COPY tls/nginx.crt ./

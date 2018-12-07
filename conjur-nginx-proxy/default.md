You can open the file by using the editor on the right.
This configuration file tells NGINX how to use TLS and behave as a proxy for Conjur.

```
listen              443 ssl;
server_name         proxy;
access_log          /var/log/nginx/access.log;
```
This block sets up a few basic properties of the NGINX server. Its hostname is `proxy`, it listens on the standard port for HTTPS (port 443) and it has a location for its access logs, useful for monitoring traffic.

```
ssl_certificate     /etc/nginx/nginx.crt;
ssl_certificate_key /etc/nginx/nginx.key;
```
This block gives NGINX its directions on how to perform TLS (“ssl” is a name for an older standard for TLS and is still often used interchangeably.)

The `certificate` is a public key, and the `certificate_key` is the corresponding private key. NGINX maintains useful documentation about how to configure the server for HTTPS, including production optimization guidelines and the values of many default settings.

```
location / {
  proxy_pass http://conjur;
}
```
This part instructs NGINX to proxy incoming traffic (secured by TLS) through to the Conjur server.

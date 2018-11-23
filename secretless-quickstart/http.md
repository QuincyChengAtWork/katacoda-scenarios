The service we're trying to connect to is listening on port 8080. If you try to access it, the service will inform you that you're unauthorized:

`curl -i localhost:8080`{{execute}}

```
HTTP/1.1 401 Unauthorized
Server: nginx/1.14.0
Date: Thu, 20 Sep 2018 16:11:44 GMT
Content-Type: text/plain
Content-Length: 26
Connection: keep-alive
WWW-Authenticate: Basic realm="Authentication required"

You are not authenticated.
```

Instead, you can make an authenticated HTTP request by proxying through the Secretless Broker on port 8081. The Secretless Broker will inject the proper credentials into the request without you needing to know what they are. Give it a try:

`http_proxy=localhost:8081 curl -i localhost:8080`{{execute}}


```
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 35
Content-Type: text/plain
Date: Thu, 20 Sep 2018 16:12:25 GMT
Server: nginx/1.14.0

You are successfully authenticated.
```


Let's spin up 2 HTTP servers for this tutorial.    
We will enable Envoy as a front proxy to secure them, without modifying the application at the end of this tutorial

```
docker run -d katacoda/docker-http-server;
docker run -d katacoda/docker-http-server;
```{{execute}}

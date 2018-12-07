[NGINX](https://www.nginx.com/) is a high performance free open source web server. This tutorial will show you how to use Docker to install Conjur and NGINX and configure them to use TLS.

### Prerequisites

This tutorial requires Docker and a terminal application. Prepare by following the prerequisite instructions found on Install Conjur.

Additionally, you will need the tutorial files from the Conjur source code repository. Here’s how you get them:

 - Install Git (it has been installed for you in this course)
 - Clone the Conjur repository

In your terminal application, run:
`git clone https://github.com/cyberark/conjur-tutorials.git`{{execute}}
This will create a folder called `conjur-tutorials` in your working directory.

### The Good Part
To start out our experience on a high note, let’s get the full Conjur+TLS stack up and running so we can inspect it.

The tutorial script will install Conjur and NGINX, configure them to work together, and connect a client to Conjur via the NGINX proxy. This is a full end-to-end working installation to allow you to see how the pieces fit.

```
# start the Conjur+NGINX tutorial servers
cd conjur-tutorials/nginx
./start.sh
```{{execute}}

Take a look at the logs for the Conjur or NGINX servers:

```
docker-compose logs conjur
docker-compose logs proxy
```{{execute}}

Run some commands in the Conjur client:

```
docker-compose exec client bash
conjur authn whoami
conjur list
```{{execute}}

### What’s happening here?
When you read the Conjur access logs, you’ll note that the Conjur server is listening on port 80 (insecure http) inside its container. However, that port is not exposed except on the local Docker network, so requests from the Internet and LAN are unable to reach it.

Meanwhile, the NGINX container is exposing its port 443 (https) to the outside network and proxying the traffic through to Conjur.

This file declares services to be used in the tutorial. Let’s break down each declaration:

<pre class="file" data-filename="conjur-tutorials/ngnix/docker-compose.yml" data-target="replace">
version: '2'
services:
  database:
    image: postgres:9.3
</pre>

Conjur requires a Postgres database to store encrypted secrets and other data. This service uses the [official Postgres image](https://hub.docker.com/_/postgres/) from DockerHub.

#### Production tip
In production, you should also secure your Postgres database with TLS. If you’re using [Amazon RDS](https://aws.amazon.com/rds/), it already has TLS support built-in. If you’re hosting your own database, you’ll want to follow the [Postgres recommendations](https://www.postgresql.org/docs/9.6/static/ssl-tcp.html).

<pre class="file" data-filename="docker-compose.yml">
  conjur:
    image: cyberark/conjur
    command: server
    environment:
      DATABASE_URL: postgres://postgres@database/postgres
      CONJUR_DATA_KEY:
    depends_on: [ database ]
</pre>

The Conjur service uses the image provided by CyberArk, connected to the database service we just defined. The empty `CONJUR_DATA_KEY` field means that Docker will pull that value in from the local environment. (Note later on that in the tutorial script we export this value.)

Note also what’s **not** present in these first two service definitions: exposed ports. These services are only accessible on the local private Docker network, not to the Internet or to the Local Area Network (LAN).


<pre class="file" data-filename="docker-compose.yml" >
  proxy:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "8443:443"
    depends_on: [ conjur ]
</pre>

The proxy service uses the [official NGINX image](https://hub.docker.com/_/nginx/) from DockerHub. It depends on the Conjur service, connecting using the local private Docker network. Unlike the Conjur or database services, it exposes a port (443, the standard port for HTTPS connections) to the Internet. This will serve as the TLS gateway for Conjur.

This service defines three volumes: the NGINX config file, a self-signed certificate, and a private key related to the certificate. Explanation of those files follows below. The files are made accessible from the local file system for read-only access by the container.

#### Production tips
For the convenience of a tutorial, we automatically generate a self-signed certificate and provide it to the proxy service. For reasons that are described in more detail [below](https://www.conjur.org/tutorials/nginx.html#tlstlsconf), this is unsuitable for production Conjur deployments.

You can use your own certificate here by providing it to the container as a volume. This allows your clients to verify that they are talking to the authentic Conjur server. Your security team can provide certificates for your organization, or you can create a certificate for any domain or sub-domain you control with certbot, which uses Let’s Encrypt to provide certificates for no cost.

To avoid conflicting with other services that might be running on the tutorial user’s port 443, we remap the port to 8443. On the production machine, the port mapping should be changed to “443:443” instead of “8443:443”.

<pre class="file" data-filename="docker-compose.yml" >
  client:
    image: cyberark/conjur-cli:5
    depends_on: [ proxy ]
    entrypoint: sleep
    command: infinity
</pre>

This service uses the `cli5` image with Conjur CLI pre-installed for convenient tinkering. It is connected to the proxy service, allowing it to access Conjur via TLS.

The “sleep” and “infinity” bits ensure that this container stays up for the duration of the demo. Without these options, the `conjurinc/cli5` image gives you an ephemeral stateless client container that performs a single command and exits, a desirable behavior for common ops use cases.


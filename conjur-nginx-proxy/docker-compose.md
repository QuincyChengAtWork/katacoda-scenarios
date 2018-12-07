This file declares services to be used in the tutorial. Let’s break down each declaration:

<pre class="file" data-filename="docker-compose.yml" data-target="replace">database:
  image: postgres:9.3
</pre>

Conjur requires a Postgres database to store encrypted secrets and other data. This service uses the [official Postgres image](https://hub.docker.com/_/postgres/) from DockerHub.


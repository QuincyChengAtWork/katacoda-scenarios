
To setup the database, we'll perform the following steps:
1. Prepare a docker-compose file for app & database 
2. Prepare the database schema
3. Prepare Dockerfile file
4. Start the app & database 


# Prepare the docker-compose.yml file

<pre class="file" data-filename="insecure-app.docker-compose.yml" data-target="replace">version: '3.6'

services:
  db:
    build:
      context: .
      dockerfile: insecure-db.Dockerfile
    image: 127.0.0.1:5000/demo_db:1.0
    restart: always

  app:
    image: cyberark/demo-app
    restart: always
    ports:
    - "8081:8080"
    environment:
      DB_URL: postgresql://db:5432/demo_db
      DB_USERNAME: demo_service_account
      DB_PASSWORD: YourStrongSAPassword 
      DB_PLATFORM: postgres
    depends_on: [ db ]
</pre>

# Load the schema sql

<pre class="file" data-filename="database.sql" data-target="replace">CREATE DATABASE demo_db;

/* connect to it */

\c demo_db;

CREATE TABLE pets (
  id serial primary key,
  name varchar(256)
);

/* Create Application User */

CREATE USER demo_service_account PASSWORD 'YourStrongSAPassword';

/* Grant Permissions */

GRANT SELECT, INSERT ON public.pets TO demo_service_account;
GRANT USAGE, SELECT ON SEQUENCE public.pets_id_seq TO demo_service_account;
</pre>

# Prepare Dockerfile file

<pre class="file" data-filename="insecure-db.Dockerfile" data-target="replace">FROM postgres:9.3
COPY database.sql /docker-entrypoint-initdb.d/init.sql
ENV POSTGRES_PASSWORD YourStrongPGPassword
</pre>

# Install docker-compose
```
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```{{execute}}


# Start the app & database
```
docker-compose -f insecure-app.docker-compose.yml build
docker-compose -f insecure-app.docker-compose.yml push
docker stack deploy --compose-file insecure-app.docker-compose.yml insecure
```{{execute}}

It will take a few moments to download and execute both the app & database

You can review the status by executing `docker service ps insecure`{{execute}}

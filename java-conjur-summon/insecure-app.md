
To setup the database, we'll perform the following steps:
1. Prepare a docker-compose file for app & database 
2. Prepare the database schema
3. Spin up the app & database 


# Prepare Dockerfile file

<pre class="file" data-filename="insecure-db.Dockerfile" data-target="replace">FROM postgres:9.4
COPY database.sql /docker-entrypoint-initdb.d/init.sql
</pre>


# Prepare the yml file

<pre class="file" data-filename="insecure-app.docker-compose.yml" data-target="replace">version: '3.6'

services:
  database:
    build:
      context: .
      dockerfile: insecure-db.Dockerfile
    image: demo_db:1.0
    restart: always
    container_name: database
    environment:
      POSTGRES_PASSWORD: NotSoSecurePassword

  app:
    image: cyberark/demo-app
    restart: always
    ports:
    - "8080:8080"
    environment:
      DB_URL: postgresql://database:5432/demo_db
      DB_USERNAME: demo_service_account
      DB_PASSWORD: NotSoSecureSAPassword 
      DB_PLATFORM: postgres
    depends_on: [ database ]
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

CREATE USER demo_service_account PASSWORD 'NotSoSecureSAPassword';

/* Grant Permissions */

GRANT SELECT, INSERT ON public.pets TO demo_service_account;
GRANT USAGE, SELECT ON SEQUENCE public.pets_id_seq TO demo_service_account;
</pre>

# Spin up the app & database
```
docker-compose -f insecure-app.docker-compose.yml up -d
```{{execute}}


To setup the database, we'll perform the following steps:
1. Prepare a yml file to spin up a PG database using docker-compose
2. Prepare the database schema
3. 


# Prepare the yml file

```
version: '2'

services:
  database:
    image: postgres:9.4
    restart: always
    container_name: postgres_database
    environment:
      POSTGRES_PASSWORD: NotSoSecurePassword
  volumes:
    - ./init.sql:/docker-entrypoint-initdb.d/init.sql

  app:
    image: cyberark/demo-app
    restart: always
    environment:
      DB_URL: postgres://postgres@database/demo_db
      DB_USERNAME: demo_service_account
      DB_PASSWORD: NotSoSecureSAPassword
      DB_PLATFORM: postgres
    depends_on: [ database ]
```

# Load the schema sql

<pre class="file" data-filename="insecure-app.docker-compose.yml" data-target="replace">CREATE DATABASE demo_db;

/* connect to it */

\c demodb;

CREATE TABLE pets (
  id serial primary key,
  name varchar(256)
);

/* Create Application User */

CREATE USER demo_service_account PASSWORD 'NotSoSecureSAPassword';

/* Grant Permissions */

GRANT SELECT, INSERT ON public.pets TO demo_service_account;
GRANT USAGE, SELECT ON SEQUENCE public.pets_id_seq TO demo_service_account;
EOSQL
</pre>

```
docker-compose -f insecure-app.docker-compose.yml up
```{{execute}}

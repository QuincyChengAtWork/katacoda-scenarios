
We will use summon to inject secrets from Conjur to the application.
More details of Summon can be found at https://docs.conjur.org/Latest/en/Content/Tools/summon.html

# Prepare the Dockerfile
<pre class="file" data-filename="secure-app.Dockerfile" data-target="replace">FROM ruby:2.4 as test-app-builder
MAINTAINER CyberArk
LABEL builder="test-app-builder"

#---some useful tools for interactive usage---#
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl

#---install summon and summon-conjur---#
RUN curl -sSL https://raw.githubusercontent.com/cyberark/summon/master/install.sh \
      | env TMPDIR=$(mktemp -d) bash && \
    curl -sSL https://raw.githubusercontent.com/cyberark/summon-conjur/master/install.sh \
      | env TMPDIR=$(mktemp -d) bash
# as per https://github.com/cyberark/summon#linux
# and    https://github.com/cyberark/summon-conjur#install
ENV PATH="/usr/local/lib/summon:${PATH}"

# ============= MAIN CONTAINER ============== #

FROM cyberark/demo-app
ARG namespace
MAINTAINER CyberArk

#---copy summon into image---#
COPY --from=test-app-builder /usr/local/lib/summon /usr/local/lib/summon
COPY --from=test-app-builder /usr/local/bin/summon /usr/local/bin/summon

#---copy secrets.yml into image---#
COPY secrets.yml /etc/secrets.yml

#---override entrypoint to wrap command with summon---#
ENTRYPOINT [ "summon", "--provider", "summon-conjur", "-f", "/etc/secrets.yml", "java", "-jar", "/app.jar"]
</pre>

# Prepare secrets.yml
<pre class="file" data-filename="secrets.yml" data-target="replace">DB_USERNAME: !var db/username
DB_PASSWORD: !var db/password
</pre>

# Prepare docker-compose file

<pre class="file" data-filename="secure-app.docker-compose.yml" data-target="replace">version: '2'

services:
  db:
    image: demo_db:1.0
    restart: always

  app:
    build:
      context: .
      dockerfile: secure-app.Dockerfile
    image: cyberark/secure-demo-app:1.0
    restart: always
    ports:
    - "8082:8080"
    environment:
      DB_URL: postgresql://db:5432/demo_db
      DB_PLATFORM: postgres
      DB_USERNAME: 
      DB_PASSWORD:  
      CONJUR_APPLIANCE_URL: https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/
      CONJUR_ACCOUNT: demo
      CONJUR_AUTHN_LOGIN: host/frontend/frontend-01
      CONJUR_AUTHN_API_KEY: ${frontend_api}
    depends_on: [ db ]
</pre>

# Start the app & database

```
docker-compose -f docker-compose.yml -f secure-app.docker-compose.yml up -d
```{{execute}}



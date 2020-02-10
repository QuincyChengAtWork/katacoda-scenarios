
We will summarize and fine tune the first step of the [offical Conjur tutorial](https://www.conjur.org/get-started/quick-start/oss-environment/) to set up a Conjur OSS environment.  If you want to know more it, please go to https://www.conjur.org/get-started/quick-start/oss-environment/


# Prepare the Setup script

<pre class="file" data-filename="setupConjur.sh" data-target="replace">#!/bin/bash
curl -o docker-compose.yml https://quincycheng.github.io/docker-compose.quickstart.yml
docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"

docker-compose up -d 
sleep 10
docker-compose exec conjur conjurctl account create demo | tee admin.out
api_key="$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"
conjur_ip="$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' tutorial_conjur_1 )"

docker-compose exec client bash -c "echo yes | conjur init -u $1 -a demo"
docker-compose exec client conjur authn login -u admin -p "$api_key"

export CONJUR_APPLIANCE_URL=http://$conjur_ip
export CONJUR_ACCOUNT="demo"
export CONJUR_AUTHN_LOGIN="admin"
export CONJUR_AUTHN_API_KEY="$api_key"
</pre>

```
chmod +x setupConjur.sh
```{{execute}}


Let's pull and setup a Conjur OSS. It will take a couple of moments 
```
./setupConjur.sh https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/
```{{execute}}


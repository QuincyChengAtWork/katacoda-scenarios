#!/bin/bash
curl -o docker-compose.yml https://quincycheng.github.io/docker-compose.quickstart.yml
docker-compose pull
docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"

docker-compose up -d 
sleep 10
docker-compose exec conjur conjurctl account create demo | tee admin.out
api_key="$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"
conjur_ip="$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' root_conjur_1 )"

docker-compose exec client bash -c "echo yes | conjur init -u $1 -a demo"
docker-compose exec client conjur authn login -u admin -p "$api_key"

export CONJUR_APPLIANCE_URL=${1%/}
export CONJUR_ACCOUNT=demo
export CONJUR_AUTHN_LOGIN=admin
export CONJUR_AUTHN_API_KEY="$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"
export CONJUR_MAJOR_VERSION=5
export CONJUR_VERSION=5

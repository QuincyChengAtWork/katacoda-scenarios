#!/bin/bash
curl -o docker-compose.yml https://www.conjur.org/get-started/docker-compose.quickstart.yml
docker-compose pull database conjur
docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"
docker-compose up -d database conjur
sleep 10
docker-compose exec conjur conjurctl account create demo | tee admin.out
api_key="$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"

#Install Conjur CLI
apt-get update -y
apt-get install -y ruby ruby-dev rubygems gcc make build-essential g++
gem install conjur-cli

echo yes | conjur init -u $1 -a demo
conjur authn login -u admin -p "$api_key"


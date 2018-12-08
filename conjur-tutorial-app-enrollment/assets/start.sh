#!/bin/bash
curl -o docker-compose.yml https://www.conjur.org/get-started/docker-compose.quickstart.yml
docker-compose pull
docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"

docker-compose up -d 
sleep 10
docker-compose exec conjur conjurctl account create demo | tee admin.out
api_key="$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"

#Install Conjur CLI
#apt-get update -y
#apt-get install -y ruby ruby-dev rubygems gcc make build-essential g++
#gem install conjur-cli

docker-compose exec client bash -c "echo yes | conjur init -u $1 -a demo"
docker-compose exec client conjur authn login -u admin -p "$api_key"
docker-compose exec client bash -c "mkdir /app"

cat >>~/.bin/conjur<<EOF
docker cp ~/tutorial/ tutorial_client_1:/app
docker-compose exec client bash -c "conjur $@"
EOF

chmod +x ~/.bin/conjur

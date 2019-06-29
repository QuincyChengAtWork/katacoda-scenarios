#!/bin/bash
sudo service docker restart
curl -o docker-compose.yml https://quincycheng.github.io/docker-compose.quickstart.yml
docker-compose pull
docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"
docker-compose up -d 
sleep 10
docker-compose exec conjur conjurctl account create demo | tee admin.out
docker-compose exec client bash -c "echo yes | conjur init -u $1 -a demo"
sleep 10
api_key="$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"
docker-compose exec client conjur authn login -u admin -p "$api_key"

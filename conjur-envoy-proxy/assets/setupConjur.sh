#!/bin/bash
curl -o docker-compose.yml https://www.conjur.org/get-started/docker-compose.quickstart.yml
docker-compose pull
docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"

docker-compose up -d 
sleep 10
docker-compose exec conjur conjurctl account create demo | tee admin.out

docker-compose exec client bash -c "echo yes | conjur init -u $1 -a demo"

echo "Waiting for Conjur to start."
until $(curl --output /dev/null --silent --head --fail http://conjur); do
    printf '.'
    sleep 5
done

api_key="$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"
docker-compose exec client conjur authn login -u admin -p "$api_key"

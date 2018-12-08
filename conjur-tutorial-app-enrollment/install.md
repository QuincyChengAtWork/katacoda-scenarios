If you would like to prepare your own docker environment, please refer to www.conjur.org or https://katacoda.com/quincycheng for more deployment tutorials

Execute the following command to create a self-hosted Conjur.
```
cat >> start.sh << EOF
curl -o docker-compose.yml https://www.conjur.org/get-started/docker-compose.quickstart.yml
docker-compose pull
docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"
docker-compose up -d
sleep 10
docker-compose exec conjur conjurctl account create test | tee test.out
api_key="$(grep API test.out | cut -d: -f2 | tr -d ' \r\n')"
docker-compose exec client bash -c "echo yes | conjur init -u https://proxy -a test"
docker-compose exec client conjur authn login -u admin -p "$api_key"
EOF
chmod +x start.sh
./start.sh
```{{execute}}


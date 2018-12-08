#!/usr/bin/env bash

# Pull required container images from Docker Hub
docker-compose pull

# Remove containers, certs and keys created in earlier tutorial runs (if any)
rm -f tls/nginx.key tls/nginx.crt
docker-compose down
docker rmi tutorial_proxy

# Create a self-signed certificate and key for TLS
openssl req\
       -x509 \
       -nodes \
       -days 365 \
       -newkey rsa:2048 \
       -config tls/tls.conf \
       -extensions v3_ca \
       -keyout tls/nginx.key \
       -out tls/nginx.crt

# Generate a data key for Conjur encryption of data at rest.
# *** Prevent data loss: ***
# Move this key to a safe place before deploying in production!
docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"

# Start services and wait a little while for them to become responsive
docker-compose up -d

#Sleep for 9s
sleep 9 &
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done

# Create a new account in Conjur and fetch its API key
# *** Protect your secrets: ***
# Rotate the admin's API key regularly!
docker-compose exec conjur conjurctl account create test | tee test.out
api_key="$(grep API test.out | cut -d: -f2 | tr -d ' \r\n')"

# Configure the Conjur client and log in as admin
docker-compose exec client bash -c "echo yes | conjur init -u https://proxy -a test"
docker-compose exec client conjur authn login -u admin -p "$api_key"

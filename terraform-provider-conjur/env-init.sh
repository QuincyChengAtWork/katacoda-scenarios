#!/bin/bash

echo "Preparing the environment.  It will take a few moments."

cd /root
curl -sO https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/terraform-provider-conjur/assets/conjur.tf
curl -sO https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/terraform-provider-conjur/assets/conjur.yml
curl -sO https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/terraform-provider-conjur/assets/docker.tf
curl -sO https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/terraform-provider-conjur/assets/postgres.tf
curl -sO https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/terraform-provider-conjur/assets/secrets.yml
curl -sO https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/terraform-provider-conjur/assets/setupConjur.sh
chmod +x setupConjur.sh

apt-get update
apt-get install -y unzip wget 


clear && echo "The environment is now ready!"

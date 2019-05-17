#!/bin/bash

curl -sO https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/terraform-provider-conjur/assets/conjur.tf
curl -sO https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/terraform-provider-conjur/assets/conjur.yml
curl -sO https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/terraform-provider-conjur/assets/docker.tf
curl -sO https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/terraform-provider-conjur/assets/postgres.tf
curl -sO https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/terraform-provider-conjur/assets/secrets.yml
curl -sO https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/terraform-provider-conjur/assets/setupConjur.sh
chmod +x setupConjur.sh

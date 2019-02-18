#!/bin/bash

refresh_token=$(curl -s --user admin:$conjur_admin $conjur_url/authn/demo/login)
access_token=$(curl -s -X POST ${conjur_url}/authn/demo/admin/authenticate -d ${refresh_token})


echo "Conjur URL: "$conjur_url
echo "Conjur Org: demo"
echo "Conjur User Name: admin"
echo "Conjur Password: "$conjur_admin
echo "Conjur Refresh Token: "$refresh_token
echo "Conjur Access Token: "$access_token


To get a bash shell with the Conjur client software:

`docker-compose exec client bash`{{execute}}

Initialize the Conjur client using the account name and admin API key you created:

`conjur init -u conjur -a quick-start`{{execute}} 

`conjur authn login -u admin`{{execute}}

Please enter the API key for admin in previous step.

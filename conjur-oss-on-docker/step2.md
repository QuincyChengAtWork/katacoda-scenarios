Run docker-compose up -d to run the Conjur server, database and client
Create a default account (eg. quick-start):

`docker-compose exec conjur conjurctl account create quick-start`{{execute}}

> Prevent data loss:
> The conjurctl account create command gives you the public key and admin API key for the account you created. Back them up in a safe location.

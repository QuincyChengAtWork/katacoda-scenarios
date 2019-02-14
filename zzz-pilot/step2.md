To run the Conjur server, database and client:

`docker-compose up -d`{{execute}}

To create a default account (eg. quick-start):

```
docker-compose exec conjur conjurctl account create quick-start | tee admin.out
```{{execute}}

> Prevent data loss:
> The conjurctl account create command gives you the public key and admin API key for the account you created. Back them up in a safe location.

### Please copy the API key for admin for logging in to the system

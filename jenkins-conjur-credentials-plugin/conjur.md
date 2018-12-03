
_If you'd like to deploy Conjur on your own environment or need more details, check out https://www.conjur.org/get-started/install-conjur.html or more tutorials at https://www.katacoda.com/quincycheng_


### Download & Pull
In your terminal, download the Conjur quick-start configuration.   It will take a few minutes to pull the images.
```
curl -o docker-compose.yml https://www.conjur.org/get-started/docker-compose.quickstart.yml
docker-compose pull
```{{execute}}


### Generate Master Key
Generate your master data key and load it into the environment:

```
docker-compose run --no-deps --rm conjur data-key generate > data_key
```{{execute}}

> Prevent data loss:
> The conjurctl conjur data-key generate command gives you a master data key. Back it up in a safe location.

### To run the Conjur server, database and client:

```
export CONJUR_DATA_KEY="$(< data_key)"
docker-compose up -d
```{{execute}}

To create a default account (eg. quick-start):

`docker-compose exec conjur conjurctl account create quick-start > admin_key`{{execute}}

To view the account created, run:
`cat admin_key`{{execute}}

If there are errors returned, it is likely that the container is still spinning up.
Please repeat this step by running docker-compose command to create the account again.

> Prevent data loss:
> The conjurctl account create command gives you the public key and admin API key for the account you created. Back them up in a safe location.


** Please backup the API key for admin for logging in to the system **



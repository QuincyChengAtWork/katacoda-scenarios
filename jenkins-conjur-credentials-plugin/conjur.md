
_If you'd like to deploy Conjur on your own environment or need more details, check out https://www.conjur.org/get-started/install-conjur.html or more tutorials at https://www.katacoda.com/quincycheng_


### Download & Pull
In your terminal, download the Conjur quick-start configuration.   It will take a few minutes to pull the images.
```
curl -o docker-compose.yml https://quincycheng.github.io/docker-compose.quickstart.yml
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

To verify the containers are up & running, run 
`docker ps`{{execute}}

The result should be similar to the following:
```
CONTAINER ID        IMAGE                          COMMAND                  CREATED             STATUS             PORTS                                              NAMES
56100b59ce7b        conjurinc/cli5                 "sleep infinity"         8 minutes ago       Up 8 minutes                                                           tutorial_client_1
149e88c645a1        cyberark/conjur                "conjurctl server"       8 minutes ago       Up 8 minutes        0.0.0.0:8080->80/tcp                               tutorial_conjur_1
62529deb2e8f        postgres:9.3                   "docker-entrypoint.s…"   8 minutes ago       Up 8 minutes        5432/tcp                                           tutorial_database_1
ab0ac454bfbe        jenkins/jenkins:2.112-alpine   "/sbin/tini -- /usr/…"   11 minutes ago      Up 11 minutes       0.0.0.0:50000->50000/tcp, 0.0.0.0:8181->8080/tcp   jenkins
```


To create a default account (eg. quick-start):

`docker-compose exec conjur conjurctl account create quick-start | tee admin_key`{{execute}}

If there are errors returned, it is likely that the container is still spinning up.
Please repeat this step by running docker-compose command to create the account again.

> Prevent data loss:
> The conjurctl account create command gives you the public key and admin API key for the account you created. Back them up in a safe location.


** Please backup the API key for admin for logging in to the system **



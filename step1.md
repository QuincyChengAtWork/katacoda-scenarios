# Step 1 - Prepare to launch

1. In your terminal, examine the Conjur quick-start configuration:

`cat docker-compose.yml `{{execute}}

The quick-start configuration is avaliable at: https://www.conjur.org/get-started/docker-compose.quickstart.yml

2. Pull all the required Docker images from DockerHub

docker-compose can do this for you automatically:


`docker-compose pull`{{execute}}

3. Generate your master data key and load it into the environment:

`docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"`{{execute}}

>Prevent data loss:
>The conjurctl conjur data-key generate command gives you a master data key. Back it up in a safe location.

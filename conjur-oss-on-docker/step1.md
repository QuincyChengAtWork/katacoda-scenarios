# Step 1 - Prepare to launch

In your terminal, download the Conjur quick-start configuration:

`curl -o docker-compose.yml https://www.conjur.org/get-started/docker-compose.quickstart.yml`{{execute}}


Pull all the required Docker images from DockerHub

docker-compose can do this for you automatically:


`docker-compose pull`{{execute}}

Generate your master data key and load it into the environment:

`docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"`{{execute}}

>Prevent data loss:
>The conjurctl conjur data-key generate command gives you a master data key. Back it up in a safe location.
Download and run the Secretless Broker quick-start as a Docker container:

`docker container run \
--rm \
-p 2221:22 \
-p 2222:2222 \
-p 8080:80 \
-p 8081:8081 \
-p 5432:5432 \
-p 5454:5454 \
cyberark/secretless-broker-quickstart &`{{execute}}

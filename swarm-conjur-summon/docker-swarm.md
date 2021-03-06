
# Create Swarm Mode Cluster
Swarm Mode is built into the Docker CLI. You can find an overview the possibility commands via docker swarm --help

The most important one is how to initialise Swarm Mode. Initialisation is done via init.

`docker swarm init`{{execute}}

After running the command, the Docker Engine knows how to work with a cluster and becomes the manager. 

# To verify the nodes in the cluster

`docker node ls`{{execute}}

# Join Swarm Worker to Cluster

The first task is to obtain the token required to add a worker to the cluster. 

Let's login to worker node

`ssh host02`{{execute}}
Are you sure you want to continue connecting (yes/no)? `yes`{{execute}}

For demonstration purposes, we'll ask the manager what the token is via swarm join-token. In production, this token should be stored securely and only accessible by trusted individuals.

On the second host, join the cluster by requesting access via the manager. The token is provided as an additional parameter.

```
docker swarm leave --force
token=$(ssh -o StrictHostKeyChecking=no host01 "docker swarm join-token -q worker") && docker swarm join host01:2377 --token $token
```{{execute}}

By default, the manager will automatically accept new nodes being added to the cluster. You can view all nodes in the cluster using docker node ls

Before proceeding to the next step, let's log off the worker node...

`exit`{{execute}}

# To verify the nodes in the cluster

`docker node ls`{{execute}}

# Registry

We will create a Registry service to host the images
`docker service create --name registry --publish published=5000,target=5000 registry:2`{{execute}}

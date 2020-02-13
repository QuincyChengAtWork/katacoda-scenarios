
# Create Swarm Mode Cluster
Swarm Mode is built into the Docker CLI. You can find an overview the possibility commands via docker swarm --help

The most important one is how to initialise Swarm Mode. Initialisation is done via init.

`docker swarm init`{{execute}}

After running the command, the Docker Engine knows how to work with a cluster and becomes the manager. The results of an initialisation is a token used to add additional nodes in a secure fashion. Keep this token safe and secure for future use when scaling your cluster.

# Join Swarm Worker to Cluster

The first task is to obtain the token required to add a worker to the cluster. 

Let's login to worker node

`ssh host02`{{execute}}
Are you sure you want to continue connecting (yes/no)? `yes`{{execute}}

For demonstration purposes, we'll ask the manager what the token is via swarm join-token. In production, this token should be stored securely and only accessible by trusted individuals.

On the second host, join the cluster by requesting access via the manager. The token is provided as an additional parameter.

`token=$(ssh -o StrictHostKeyChecking=no host01 "docker swarm join-token -q worker") && docker swarm join host01:2377 --token $token`{{execute}}

By default, the manager will automatically accept new nodes being added to the cluster. You can view all nodes in the cluster using docker node ls

# Registry

`docker service create --name registry --publish published=5000,target=5000 registry:2`{{execute}}

Before proceeding to the next step, let's log off the worker node...

`exit`{{execute}}

and verify the nodes in the cluster

`docker node ls`{{execute}}

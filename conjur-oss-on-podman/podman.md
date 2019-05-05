

First, let's update the package list

`apt-get update`{{execute}}

Then, let's add the repository for podman 

`add-apt-repository -y ppa:projectatomic/ppa`{{execute}}

We'll update the package list again

`apt-get update `{{execute}}

Now, let's install podman

`apt-get -y install podman`{{execute}}

To verify the installation, let's display the version of podman deployed

`podman --version`{{execute}}

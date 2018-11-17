

## 1. Configure Env Variables for Conjur
`export CONJUR_VERION=5`{{execute}}

`export PLATFORM=kubernetes`{{execute}}

## 2. Configure Kubernetes Config

### Conjur Namespace
`export CONJUR_NAMESPACE_NAME=CONJUR`{{execute}}

### The conjur-authenticator Cluster Role

Conjur's Kubernetes authenticator requires the following privileges:

["get", "list"] on "pods" for confirming a pod's namespace membership
["create", "get"] on "pods/exec" for injecting a certificate into a pod
The deploy scripts include a manifest that defines the conjur-authenticator cluster role, which grants these privileges. Create the role now (note that your user will need to have the cluster-admin role to do so):

`kubectl apply -f ./kubernetes/conjur-authenticator-role.yaml`{{execute}}


## 2. Check Dependency

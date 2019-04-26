
We will now configure and load the Conjur policies, plus storing the database secrets to Conjur OSS.

There are a couple of policies in Conjur cluster & authenticator:

 - Policy for human users: `cat policy/users.yml`{{execute}}
 - Policy for authentication identities: `cat policy/app-id.yml`{{execute}}
 - Policy for the Kubernetes authenticator service: `cat policy/cluster-auth-svc.yml`{{execute}}

For each application:
 - App Access: `cat policy/app-access.yml`{{execute}}
 - App ID to secrets: `cat policy/app-identity-access-to-secrets.yml`{{execute}}

To review the script for loading policies: `cat ./4_load_conjur_policies.sh`{{execute}}

To load the policies`./4_load_conjur_policies.sh`{{execute}}

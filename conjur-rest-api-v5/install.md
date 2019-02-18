
Let's set up the environment

### Client

We will use `curl` as the HTTPS client to communicate with CyberArk Conjur using REST API calls.

To verify, we can display its usage by `curl --help`{{execute}}

### Server

We will install a Conjur OSS environment as the server.   It will take a few moments.

`./setupConjur.sh https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/`{{execute}}

In production environment, it should be separately securely.

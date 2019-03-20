In this step, we will setup a Conjur OSS container, load some policies and create a machine identity for the host

### Install Conjur
Let's pull and setup a Conjur OSS.   It will take a couple of moments
`. ./setupConjur.sh https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/`{{execute}}

### Prepare Conjur Policy
The sample policies have been prepared for you. 

**Root policy**

Run `cat conjur.yml`{{execute}} to review the root policy
```
- !policy
  id: krb5

- !policy
  id: frontend
```



**Load Root Policy**

```
docker cp conjur.yml root_client_1:/tmp/
docker-compose exec client conjur policy load --replace root /tmp/conjur.yml
```{{execute}}

### Add variable
Let's create a secret and add it to Conjur

```
dbpass=$(openssl rand -hex 12)
docker-compose exec client conjur variable values add postgres/admin-password "$dbpass" 
```{{execute}}

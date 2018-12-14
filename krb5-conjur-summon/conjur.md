### Install Conjur
Let's pull and setup a Conjur OSS.   It will take a couple of moments
`./setupConjur.sh https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/`{{execute}}

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
**krb5 policy**

Run `cat krb5.yml`{{execute}} to review the root policy

```
- &variables
  - !variable keytab
- !group secrets-users
- !group secrets-users
  privileges: [ read, execute ]
  roles: !group secrets-users
- !grant
  role: !group secrets-users
  member: !layer /frontend
```

**frontend policy**

Run `cat frontend.yml`{{execute}} to review the root policy

```
- !layer
- !host frontend-01
- !grant
  role: !layer
  member: !host frontend-01
```
### Load Conjur Policies

Now let's copy the policy files to Conjur CLI container and load them
```
docker cp *.yml root_client_1:/tmp
docker-compose exec client bash -c "conjur policy load /tmp/conjur.yml"
docker-compose exec client bash -c "conjur policy load /tmp/frontend.yml" | tee frontend.out
docker-compose exec client bash -c "conjur policy load /tmp/krb5.yml"
```{{execute}}

### Add Keytab as variables
Copy the `user.keytab` file to Conjur CLI container and add to Conjur as a variable

```



```{{execute}}

### Cleanup 

```
rm user.keytab
docker-compose exec client bash -c "rm /tmp/user.keytab
```{{execute}}


The sample policies have been prepared for you. 

**Root policy**

Run `cat conjur.yml`{{execute}} to review the root policy
```
- !policy
  id: db

- !policy
  id: ansible
```
**db policy**

Run `cat db.yml`{{execute}} to review the root policy

```
- &variables
  - !variable dbpass
- !group secrets-users
- !group secrets-users
  privileges: [ read, execute ]
  roles: !group secrets-users
- !grant
  role: !group secrets-users
  member: !layer /ansible
```

**ansible policy**

Run `cat ansible.yml`{{execute}} to review the root policy

```
- !layer
- !host ansible-01
- !grant
  role: !layer
  member: !host ansible-01
```
### Load Conjur Policies

Now let's copy the policy files to Conjur CLI container and load them

**Load Root Policy**

```
docker cp conjur.yml root_client_1:/tmp/
docker-compose exec client conjur policy load --replace root /tmp/conjur.yml
```{{execute}}

**Load ansible Policy**
```
docker cp ansible.yml root_client_1:/tmp/
docker-compose exec client conjur policy load ansible /tmp/ansible.yml | tee ansible.out
```{{execute}}

**Load db Policy**
```
docker cp db.yml root_client_1:/tmp/
docker-compose exec client conjur policy load db /tmp/db.yml
```{{execute}}

### Add variable
Let's create a secret and add it to Conjur

```
dbpass=$(openssl rand -hex 12)
docker-compose exec client conjur variable values add db/dbpass $dbpass" 
```{{execute}}

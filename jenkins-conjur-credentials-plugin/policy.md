_This section refers to *Enrolling an Application* at https://www.conjur.org/tutorials/policy/applications.html_


### Login to Conjur
Initialize Conjur Client
`docker-compose exec client conjur init -u conjur -a quick-start`{{execute}}

Logon to Conjur
```
export admin_api_key="$(cat admin_key|awk '/API key for admin/ {print $NF}'|tr '  \n\r' ' '|awk '{$1=$1};1')"
docker-compose exec client conjur authn login -u admin -p $admin_api_key
```{{execute}}
It should display `Logged in` once you are successfully logged in

### Create policy files
```
docker-compose exec client bash
cat >> conjur.yml << EOF
- !policy
  id: db

- !policy
  id: frontend
EOF
cat >> db.yml << EOF
- &variables
  - !variable password

- !group secrets-users

- !permit
  resource: *variables
  privileges: [ read, execute ]
  roles: !group secrets-users

# Entitlements
- !grant
  role: !group secrets-users
  member: !layer /frontend
EOF
cat >> frontend.yml << EOF
- !layer

- !host frontend-01

- !grant
  role: !layer
  member: !host frontend-01
EOF
exit
```{{execute}}

### Load policies to Conjur

```
docker-compose exec client conjur policy load --replace root /conjur.yml
docker-compose exec client conjur policy load frontend /frontend.yml > frontend_api
docker-compose exec client conjur policy load db db.yml
cat fronend_api
```{{execute}}

**Copy the api_key generated!**

### Create secret for database
```
password=$(openssl rand -hex 12)
docker-compose exec client conjur variable values add db/password $password
docker-compose exec client conjur variable value db/password
```{{execute}}

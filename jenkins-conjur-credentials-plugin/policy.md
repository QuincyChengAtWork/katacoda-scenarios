_This section is based on **Enrolling an Application** tutorial at https://www.conjur.org/tutorials/policy/applications.html_


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

Load root policy:
`docker-compose exec client conjur policy load --replace root /conjur.yml`{{execute}}

Load frontend policy, please note that a new host entity is created
`docker-compose exec client conjur policy load frontend /frontend.yml | tee frontend.out`{{execute}}

We will use the host entity later within this tutorial, so let's put it in memory
```
export frontend_api_key=$(tail -n +2 frontend.out | jq -r '.created_roles."quick-start:host:frontend/frontend-01".api_key')
echo $frontend_api_key
```{{execute}}

Load database policy
`docker-compose exec client conjur policy load db db.yml`{{execute}}

**Copy the api_key generated!**

### Create secret for database
```
password=$(openssl rand -hex 12)
docker-compose exec client conjur variable values add db/password $password
```{{execute}}

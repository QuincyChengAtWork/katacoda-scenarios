This section describes all configuration requirements for the Jenkins plugin. It includes Conjur policy requirements, SSL certificate preparation, and Jenkins plugin configuration.   We will focus on policy requirements in this step.


### Login to Conjur
Initialize Conjur Client
`docker-compose exec client conjur init -u conjur -a quick-start`{{execute}}

Logon to Conjur
```
export admin_api_key="$(cat admin_key|awk '/API key for admin/ {print $NF}'|tr '  \n\r' ' '|awk '{$1=$1};1')"
docker-compose exec client conjur authn login -u admin -p $admin_api_key
```{{execute}}
It should display `Logged in` once you are successfully logged in


### Required Conjur Configurations
The following configurations are required on Conjur: 

- Declare the Jenkins host in Conjur policy.
- Declare variables (secrets) in Conjur policy.
- Load secret values into Conjur.


### Declare Jenkins host in Conjur policy
The following steps create Conjur policy that defines the Jenkins host and adds that host to a layer.

1. Declare a policy branch for Jenkins & save it as a .yml file

```
docker-compose exec client bash
cat > conjur.yml << EOF
- !policy
  id: jenkins-frontend
EOF
exit
```{{execute}}

2. You may change the id in the above example if desired
3. Load the policy into Conjur under root: 

`docker-compose exec client conjur policy load --replace root /conjur.yml`{{execute}}

4. Declare the layer and Jenkins host in another file. Copy the following policy as a template & save it.

```
docker-compose exec client bash
cat > jenkins-frontend.yml << EOF
- !layer
- !host frontend-01
- !grant
  role: !layer
  member: !host frontend-01
EOF
exit
```{{execute}}

This policy does the following: 

- Declares a layer that inherits the name of the policy under which it is loaded. In our example, the layer name will become jenkins-frontend.
- Declares a host named frontend-01
- Adds the host into the layer. A layer may have more than one host.
Change the following items:
- Change the host name to match the DNS host name of your Jenkins host. Change it in both the !host statement and the !grant statement.
- Optionally declare additional Jenkins hosts. Add each new host as a member in the !grant statement.

5. Load the policy into Conjur under the Jenkins policy branch you declared previously: 

`docker-compose exec client conjur policy load jenkins-frontend /jenkins-frontend.yml | tee frontend.out`{{execute}}

As it creates each new host, Conjur returns an API key.

We will use the host entity later within this tutorial, so let's put it in memory
```
export frontend_api_key=$(tail -n +2 frontend.out | jq -r '.created_roles."quick-start:host:jenkins-frontend/frontend-01".api_key')
echo $frontend_api_key
```{{execute}}

6. Save the API keys returned in the previous step. You need them later when configuring Jenkins credentials for logging into Conjur.

### Declare variables in Conjur policy

The following steps create Conjur policy that defines each variable and provides appropriate privileges to the Jenkins layer to access those variables.

If variables are already defined, you need only add the Jenkins layer to an existing permit statement associated with the variable. The following steps assume that the required variables are not yet declared in Conjur.

1. Declare a policy branch for the application & save it

```
docker-compose exec client bash
cat > conjur2.yml << EOF
- !policy
  id: jenkins-app
EOF
exit
```{{execute}}

2. You may change the id in the above example.

3. Load the policy into Conjur: 

`docker-compose exec client conjur policy load root /conjur2.yml`{{execute}}

4. Declare the variables, privileges, and entitlements. Copy the following policy as a template:

```
docker-compose exec client bash
cat > jenkins-app.yml << EOF
#Declare the secrets required by the application

- &variables
  - !variable db_password
  - !variable db_password2

# Define a group and assign privileges for fetching the secrets

- !group secrets-users

- !permit
  resource: *variables
  privileges: [ read, execute ]
  roles: !group secrets-users

# Entitlements that add the Jenkins layer of hosts to the group  

- !grant
  role: !group secrets-users
  member: !layer /jenkins-frontend
EOF
exit
```{{execute}}

This policy does the following: 
- Declares the variables to be retrieved by Jenkins.
- Declares the groups that have read & execute privileges on the variables.
- Adds the Jenkins layer to the group. The path name of the layer is relative to root.

Change the variable names, the group name, and the layer name as appropriate.

5. Load the policy into Conjur under the Jenkins policy branch you declared previously: 

`docker-compose exec client conjur policy load jenkins-app /jenkins-app.yml`{{execute}}


### Set variable values in Conjur

Use the Conjur CLI or the UI to set variable values.

The CLI command to set a value is: 

`conjur variable values add <policy-path-of-variable-name> <secret-value>`

For example: 

```
password=$(openssl rand -hex 12)
docker-compose exec client conjur variable values add jenkins-app/db_password $password
```{{execute}}

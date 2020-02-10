
Now let's enroll the app to Conjur.   We refer to the [Enroll Application](https://www.conjur.org/get-started/tutorials/enrolling-application/) tutorial on conjur.org.   For details, please visit https://www.conjur.org/get-started/tutorials/enrolling-application/

# Prepare the policy files

1. Setup
We will model a simple application in which a frontend service connects to a db server. The db policy defines service account and its password, which the frontend application uses to log in to the database.

Here is a skeleton policy for this scenario, which simply defines two empty policies: db and frontend. Save this policy as “conjur.yml”:
<pre class="file" data-filename="conjur.yml" data-target="replace">- !policy
  id: db

- !policy
  id: frontend
</pre>

Then load it using the following command:
```
docker cp conjur.yml tutorial_client_1:/tmp/
docker-compose exec client conjur policy load --replace root /tmp/conjur.yml
```{{execute}}


2. Define Protected Resources
Having defined the policy framework, we can load the specific data for the database.

Create the following file as “db.yml”:

<pre class="file" data-filename="db.yml" data-target="replace"># Declare the secrets which are used to access the database
- &variables
  - !variable username
  - !variable password

# Define a group which will be able to fetch the secrets
- !group secrets-users

- !permit
  resource: *variables
  # "read" privilege allows the client to read metadata.
  # "execute" privilege allows the client to read the secret data.
  # These are normally granted together, but they are distinct
  #   just like read and execute bits on a filesystem.
  privileges: [ read, execute ]
  roles: !group secrets-users
</pre>

Now load it using the following command:

```
docker cp db.yml tutorial_client_1:/tmp/
docker-compose exec client conjur policy load db /tmp/db.yml
```{{execute}}

And store the secrets to Conjur
Username: `docker-compose exec client conjur variable values add db/username demo_service_account`{{execute}}

Password: `docker-compose exec client conjur variable values add db/password YourStrongSAPassword`{{execute}}

Please note that the password should be rotated regularly.   CyberArk CPM can help to archieve this.  For the list of supported devices, please refer to https://marketplace.cyberark.com

# Define an Application
For this example, the “frontend” policy will simply define a Layer and a Host. Create the following file as “frontend.yml”:
<pre class="file" data-filename="frontend.yml" data-target="replace">- !layer

- !host frontend-01

- !grant
  role: !layer
  member: !host frontend-01
</pre>
  
Note Statically defining the hosts in a policy is appropriate for fairly static infrastructure. More dynamic systems such as auto-scaling groups and containerized deployments can be managed with Conjur as well. The details of these topics are covered elsewhere.
Now load the frontend policy using the following command:

```
docker cp frontend.yml tutorial_client_1:/tmp/
docker-compose exec client conjur policy load frontend /tmp/frontend.yml|tee frontend.out
```{{execute}}


Note The `api_key` printed above is a unique securely random string for each host. When you load the policy, you’ll see a different API key. Be sure and use this API key below.  In this tutorial, we will save the output in `frontend.out` and the api key as environment variable `frontend_api`.   Please make sure they are removed from your production environment.

To get the frontend api key:
```
export frontend_api=$(tail -n +2 frontend.out | jq -r '.created_roles."quick-start:host:frontend/frontend-01".api_key')
```{{execute}}

# Entitlement

Now let's grant the access by updating the `db.yml` policy:
<pre class="file" data-filename="db.yml" data-target="replace">- &variables
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
</pre>

Then load it using the CLI:
```
docker cp db.yml tutorial_client_1:/tmp/
docker-compose exec client conjur policy load db /tmp/db.yml
```{{execute}}


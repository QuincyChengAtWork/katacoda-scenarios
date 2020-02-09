
We will following the [Conjur tutorial](https://www.conjur.org/get-started/quick-start/oss-environment/) to set up a Conjur OSS environment.   It is the first step of the offical quickstart tutorial.   If you want to know more it, please go to https://www.conjur.org/get-started/quick-start/oss-environment/


# Git clone the conjur-quickstart GitHub repository
```
git clone https://github.com/cyberark/conjur-quickstart.git
```{{execute}}

# Pull the docker image
```
docker-compose -f conjur-quickstart/docker-compose.yml pull
```{{execute}}

# Generate the master key
The master data key will be used later to encrypt the database.
In the working directory, generate the key and store it to a file:
* Tip: Although not mandatory, we prefer to store sensitive data to a file and not to display it directly on console screen.

```
docker-compose -f conjur-quickstart/docker-compose.yml run --no-deps --rm conjur data-key generate > data_key
```{{execute}}


The data key is generated in the working directory and is stored in a file called data_key.

When the key is generated, the terminal returns the following:
```
Creating network "conjur-quickstart_default" with the default driver
```

# Load master key as an environment variable
Load data_key file content (the master data key) as an environment variable:

```
export CONJUR_DATA_KEY="$(< data_key)"
```{{execute}}

# Start the Conjur OSS environment

```
docker-compose up -d
```{{execute}}

When Conjur OSS starts, the terminal returns the following:
```
Creating postgres_database ... done
Creating bot_app ... done
Creating openssl ... done
Creating conjur_server ... done
Creating nginx_proxy ... done
Creating conjur_client ... done
```

Verification
Run the following command to see a list of running containers:

`docker ps -a`{{execute}}


# Create admin account
Create a Conjur account and initialize the built-in admin user.

```
docker-compose exec conjur conjurctl account create myConjurAccount > admin_data
```{{execute}}
An account named `myConjurAccount` is created and the admin user is initialized, following keys are created and stored at `admin_data` file:

- admin user API key. Later on, we will use this key to log in to Conjur.
- myConjurAccount Conjur account public key.


# Connect the Conjur client to the Conjur server
This is a one-time action. For the duration of the container’s life or until additional initcommand is issued, the Conjur client and the Conjur server remain connected.
Use the account name that you created in step 5:

```
docker-compose exec client conjur init -u conjur -a myConjurAccount
```
Verification
The terminal returns the following output:

`Wrote configuration to /root/.conjurrc`


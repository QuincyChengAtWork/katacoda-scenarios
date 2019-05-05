
**Server**

First, we'll create a pod for Conjur OSS

`podman pod create -n conjur-oss --share net -p 8080:80`{{execute}}

Then, the database container will be spinned up

`podman run --name database -d --pod conjur-oss --add-host conjur:127.0.0.1 --add-host database:127.0.0.1 docker.io/postgres:9.3`{{execute}}

Next, we will generate a data key for Conjur OSS

`podman run --rm docker.io/cyberark/conjur data-key generate > data_key &&  export CONJUR_DATA_KEY="$(< data_key)"`{{execute}}

Finally, the container for Conjur OSS will be created. 

`podman run --name conjur -d --pod=conjur-oss -e CONJUR_DATA_KEY="$CONJUR_DATA_KEY" -e DATABASE_URL=postgres://postgres@database/postgres --add-host database:127.0.0.1  docker.io/cyberark/conjur server `{{execute}}

**Initialize Conjur***

Let's create an account

`podman exec conjur conjurctl account create quick-start | tee admin.out `{{execute}}


**Client**

To prepare the necessary information, including admin API Key, Conjur IP address & folder storage:

```
export api_key="$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"
export SERVICE_IP=$(ifconfig ens3| grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1)
mkdir mydata
```{{execute}}

Let's initialize Conjur CLI

`podman run --rm -it -v $(pwd)/mydata/:/root --entrypoint bash docker.io/cyberark/conjur-cli:5 -c "echo yes | conjur init -a quick-start -u http://$SERVICE_IP:8080"`{{execute}}

To Login:

`podman run --rm -it -v $(pwd)/mydata/:/root docker.io/cyberark/conjur-cli:5 authn login -u admin -p $api_key`{{execute}}

And verify the logon user:

`podman run --rm -it -v $(pwd)/mydata/:/root docker.io/cyberark/conjur-cli:5 authn whoami`{{execute}}


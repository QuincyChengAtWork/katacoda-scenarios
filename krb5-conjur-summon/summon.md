### Install Summon
Installing Summon is simple.  Simply download 2 files and summon is ready to go.

```
curl -OL https://github.com/cyberark/summon/releases/download/v0.6.9/summon-linux-amd64.tar.gz
tar zvxf summon-linux-amd64.tar.gz
cp -f summon /usr/local/bin/

curl -OL https://github.com/cyberark/summon-conjur/releases/download/v0.5.2/summon-conjur-linux-amd64.tar.gz
tar zvxf summon-conjur-linux-amd64.tar.gz 
mkdir /usr/local/lib/summon/
cp -f summon-conjur /usr/local/lib/summon/
```{{execute}}

### Configure Summon
Let's configure summon by using environmental variables.
For more details, please refer to [Conjur provider for Summon](https://github.com/cyberark/summon-conjur)
```
export CONJUR_MAJOR_VERSION=5
export CONJUR_ACCOUNT=demo
export CONJUR_APPLIANCE_URL=https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/
export CONJUR_AUTHN_LOGIN=host/frontend/frontend-01
export CONJUR_AUTHN_API_KEY=$(tail -n +2 frontend.out | jq -r '.created_roles."demo:host:frontend/frontend-01".api_key')
```{{execute}}

We will make sure of `secrets.yml` file for injecting the keytab file
To review it, run `cat secrets.yml`{{execute}}
```
KEYTAB: !var:file krb5/keytab
```


### Summon Keytab
To summon keytab, we can get the path to memeory-mapped keytab files using the environment variable `KEYTAB`, which defined in `secrets.yml`

`summon bash -c 'kinit quincy@CYBERARKDEMO.COM -k -t $KEYTAB'`{{execute}}

`klist`{{execute}}

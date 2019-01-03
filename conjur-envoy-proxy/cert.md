### Prepare Conjur Policy
The sample policies have been prepared for you. 

**Root policy**

Run `cat conjur.yml`{{execute}} to review the root policy
```
- !policy
  id: cert
- !policy
  id: envoy
```
**cert policy**

Run `cat cert.yml`{{execute}} to review the root policy

```
- &variables
  - !variable private_key
  - !variable cert_chain
- !group secrets-users
- !permit
  resource: *variables
  privileges: [ read, execute ]
  roles: !group secrets-users
- !grant
  role: !group secrets-users
  member: !layer /envoy
```

**envoy policy**

Run `cat envoy.yml`{{execute}} to review the root policy

```
- !layer
- !host envoy-01
- !grant
  role: !layer
  member: !host envoy-01
```
### Load Conjur Policies

Now let's copy the policy files to Conjur CLI container and load them

**Load Root Policy**

```
docker cp conjur.yml root_client_1:/tmp/
docker-compose exec client conjur policy load --replace root /tmp/conjur.yml
```{{execute}}

**Load Envoy Policy**
```
docker cp envoy.yml root_client_1:/tmp/
docker-compose exec client conjur policy load envoy /tmp/envoy.yml | tee frontend.out
```{{execute}}

**Load cert Policy**
```
docker cp cert.yml root_client_1:/tmp/
docker-compose exec client conjur policy load cert /tmp/cert.yml
```{{execute}}

### Add certificate chain & private key as variables
Copy the `cyberarkdemo-com.crt` & `cyberarkdemo-com.key` files to Conjur CLI container and add to Conjur as a variable

```
docker cp certs/cyberarkdemo-com.crt root_client_1:/tmp/
docker cp certs/cyberarkdemo-com.key root_client_1:/tmp/
docker-compose exec client bash -c "echo /tmp/cyberarkdemo-com.crt | conjur variable values add cert/cert_chain"
docker-compose exec client bash -c "echo /tmp/cyberarkdemo-com.key | conjur variable values add cert/private_key"
```{{execute}}

### Cleanup 
It's time to remove the keytab files

```
rm -f certs/cyberarkdemo-com.crt
rm -f certs/cyberarkdemo-com.key
docker-compose exec client bash -c "rm /tmp/cyberarkdemo-com.crt"
docker-compose exec client bash -c "rm /tmp/cyberarkdemo-com.key"
```{{execute}}

To verify:
`ls certs/`{{execute}}

`docker-compose exec client bash -c "ls /tmp/cyberarkdemo-com.*"`{{execute}}

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
export CONJUR_APPLIANCE_URL=https://localhost/conjur
export CONJUR_AUTHN_LOGIN=host/frontend/frontend-01
export CONJUR_AUTHN_API_KEY=$(tail -n +2 frontend.out | jq -r '.created_roles."demo:host:envoy/envoy-01".api_key')
```{{execute}}

We will make sure of `secrets.yml` file for injecting the certificate chain & private key
To review it, run `cat secrets.yml`{{execute}}
```
CRT: !var:file cert/cert_chain
KEY: !var:file cert/private_key
```

### Restart Envoy
First, let's stop the running Envoy
```
docker kill proxy1;
docker rm proxy 1;
```{{execute}}

To summon certificate chain & private key, we can get the path to memeory-mapped cert files using the environment variable `CERT` & `KEY`, which defined in `secrets.yml`

```
summon docker run --entrypoint "/usr/local/bin/envoy -c /etc/envoyproxy.yaml --config-yaml \"static_resources:listeners:\"" -d --name proxy1 -p 80:8080 -p 443:8443 -p 8001:8001 -v /root/:/etc/envoy/ envoyproxy/envoy
```{{execute}}

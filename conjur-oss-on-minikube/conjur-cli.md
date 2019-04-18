

### Load Deployment

`kubectl create -f conjur-cli.yml`{{execute}}

### Get Details

```
export cli_pod_name="$( kubectl get pods --selector app=conjur-cli --no-headers | awk '{ print $1 }' )"
export conjur_service="$( kubectl get services | grep "conjur-oss" | grep -v "ingress" | awk '{ print $1 }' )"
export CONJUR_ADMIN_PASSWORD=$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')
```{{execute}}

### Wait!
It will take a moment for the container to spin up.   If you got any error after executing the following actions, please wait for a moment and try again.

### Login

#### Conjur init

`kubectl exec -it $cli_pod_name -- conjur init -a quickstart -u https://$conjur_service`{{execute}}

Trust this certificate (yes/no): `yes`{{execute}}

#### Conjur Login
`kubectl exec -it $cli_pod_name -- conjur authn login -u admin -p $CONJUR_ADMIN_PASSWORD`{{execute}}

### Copy Certificate for next step

`kubectl cp $cli_pod_name:/root/conjur-quickstart.pem .`{{execute}}

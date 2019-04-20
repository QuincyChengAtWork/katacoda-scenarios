

### Load Deployment

`kubectl create -f conjur-cli.yml --namespace $CONJUR_NAMESPACE`{{execute}}

### Get Details

```
export cli_pod_name="$( kubectl get pods --selector app=conjur-cli --no-headers --namespace $CONJUR_NAMESPACE | awk '{ print $1 }' )"

export CONJUR_ADMIN_PASSWORD=$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')
```{{execute}}

### Wait!
It will take a moment for the container to spin up.   If you got any error after executing the following actions, please wait for a moment and try again.

### Login

#### Conjur init

`kubectl exec --namespace $CONJUR_NAMESPACE -it $cli_pod_name -- conjur init -a quincy -u https://$CONJUR_ALT_HOSTNAME_SSL`{{execute}}

Trust this certificate (yes/no): `yes`{{execute}}

#### Conjur Login
`kubectl exec --namespace $CONJUR_NAMESPACE -it $cli_pod_name -- conjur authn login -u admin -p $CONJUR_ADMIN_PASSWORD`{{execute}}

### Copy Certificate for next step

`kubectl cp --namespace $CONJUR_NAMESPACE $cli_pod_name:/root/conjur-quincy.pem .`{{execute}}

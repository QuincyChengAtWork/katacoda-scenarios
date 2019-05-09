
You can refer to official docuemntation at https://docs.conjur.org and deployment scenarios at https://katacoda.com/quincycheng 



## Client installation (helm)

`oc adm policy add-cluster-role-to-user cluster-admin admin --as=system:admin
oc adm policy add-cluster-role-to-user cluster-admin developer --as=system:admin
oc adm policy add-scc-to-user anyuid -z default
curl -ks https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz | tar xz
sudo mv linux-amd64/helm /usr/local/bin
sudo chmod a+x /usr/local/bin/helm
helm init --client-only`{{execute}}

## Server installation (tiller)

With helm being the client only, Helm needs an agent named "tiller" on the kubernetes cluster. Therefore we create a project (namespace) for this agent an install it with "oc create"

`export TILLER_NAMESPACE=tiller
oc new-project tiller
oc project tiller
oc policy add-role-to-user edit "system:serviceaccount:${TILLER_NAMESPACE}:tiller"
oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:tiller:tiller --as=system:admin
oc process -f https://quincycheng.github.io/tiller-template.yaml -p TILLER_NAMESPACE="${TILLER_NAMESPACE}" | oc create -f -
oc rollout status deployment tiller`{{execute}}

Let's verify the helm installation is okay.  Please wait for a while for server up & running if an error is shown:

`helm version`{{execute}}

### Add CyberArk Chart

`helm repo add cyberark https://cyberark.github.io/helm-charts
helm repo update`{{execute}}

## Preparing your projects (namespaces)

Finally you have to give tiller access to each of the namespaces you want someone to manage using helm:

Prepare the Conjur project
`export TILLER_NAMESPACE=tiller
oc new-project conjur
oc project conjur
oc policy add-role-to-user edit "system:serviceaccount:${TILLER_NAMESPACE}:tiller"
oc adm policy add-scc-to-user anyuid -z conjur`{{execute}}

## Install Conjur
`#helm install \
  --set dataKey="$(docker run --rm cyberark/conjur data-key generate)" \
  cyberark/conjur-oss`{{execute}}


```
source bootstrap.env
helm install cyberark/conjur-oss \
    --set ssl.hostname=$CONJUR_HOSTNAME_SSL,dataKey="$(docker run --rm cyberark/conjur data-key generate)",authenticators="authn-k8s/dev\,authn" \
    --namespace "$CONJUR_NAMESPACE" \
    --name "$CONJUR_APP_NAME"
```{{execute}}

Create an Account for Conjur, please wait for a while to retry if an error is shown
```
export POD_NAME=$(oc get pods --namespace "$CONJUR_NAMESPACE" \
    -l "app=conjur-oss" \
    -o jsonpath="{.items[0].metadata.name}")
oc exec $POD_NAME --container=conjur-oss conjurctl account create "default"
```{{execute}}
  
Finish!   
 

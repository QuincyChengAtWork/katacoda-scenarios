


### 1. Install Helm & CyberArk charts

Helm is a single binary that manages deploying Charts to Kubernetes. A chart is a packaged unit of kubernetes software. It can be downloaded from https://github.com/kubernetes/helm/releases

`curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz
tar -xvf helm-v2.13.1-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/`{{execute}}

Once installed, initialise update the local cache to sync the latest available packages with the environment.

`helm init`{{execute}}

Add CyberArk Helm repo

`helm repo add cyberark https://cyberark.github.io/helm-charts
helm repo update`{{execute}}

### 2. View & Inspect CyberArk charts (optional)

View all CyberArk charts
`helm search -r 'cyberark/*'`{{execute}}

Inspect and install a chart
`helm inspect cyberark/conjur-oss`{{execute}}

### 3. Install Conjur using Helm

`helm install \
  --set dataKey="$(docker run --rm cyberark/conjur data-key generate)" \
  --set account=quickstart \
  --set ssl.hostname="[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com" \
  --set image.pullPolicy=IfNotPresent \
  --set postgres.persistentVolume.create=false \
  --set service.external.enabled=false \
  cyberark/conjur-oss`{{execute}}
  
Please wait for a while if an error is shown - Most likely the tiller is being started.  


### 4. Configure Conjur
  To create an initial account as "quickstart" and login
  
  `export POD_NAME=$(kubectl get pods --namespace default -l "app=conjur-oss" -o jsonpath="{.items[0].metadata.name}")
  kubectl exec $POD_NAME --container=conjur-oss conjurctl account create "quickstart" | tee admin.out
  `{{execute}}

Detailed instructions here: https://www.conjur.org/get-started/install-conjur.html#install-and-configure

>  Note that the conjurctl account create command gives you the public key and admin API key for the account you created.
>  Back them up in a safe location.

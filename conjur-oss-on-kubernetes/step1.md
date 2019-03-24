

## 1. Install Helm & CyberArk charts

Helm is a single binary that manages deploying Charts to Kubernetes. A chart is a packaged unit of kubernetes software. It can be downloaded from https://github.com/kubernetes/helm/releases

`curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz
tar -xvf helm-v2.13.1-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/`{{execute}}

Once installed, initialise update the local cache to sync the latest available packages with the environment.

`helm init`{{execute}}

Add CyberArk Helm repo

`helm repo add cyberark https://cyberark.github.io/helm-charts
helm repo update`{{execute}}

## 2. View & Inspect CyberArk charts (optional)

View all CyberArk charts
`helm search -r 'cyberark/*'`{{execute}}

Inspect and install a chart
`helm inspect cyberark/conjur-oss`{{execute}}

## 3. Install Conjur using Helm

`helm install \
  --set dataKey="$(docker run --rm cyberark/conjur data-key generate)" \
  --set account=quickstart \
  --set ssl.hostname="https://[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com/" \
  cyberark/conjur-oss`{{execute}}
  
Please wait for a while if an error is shown - Most likely the tiller is being started.  

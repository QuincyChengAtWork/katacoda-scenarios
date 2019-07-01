

Enable the dashboard using Minikube with the command `minikube addons enable dashboard`{{execute}}

Make the Kubernetes Dashboard available by deploying the following YAML definition. This should only be used on Katacoda.

`kubectl apply -f /opt/kubernetes-dashboard.yaml`{{execute}}

The Kubernetes dashboard allows you to view your applications in a UI. In this deployment, the dashboard has been made available on port 30000.

The URL to the dashboard is https://[[HOST_SUBDOMAIN]]-30000-[[KATACODA_HOST]].environments.katacoda.com/

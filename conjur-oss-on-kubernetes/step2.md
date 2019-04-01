
## 1. Configure Conjur
  To create an initial account as "quickstart" and login
  
  `export POD_NAME=$(kubectl get pods --namespace default -l "app=conjur-oss" -o jsonpath="{.items[0].metadata.name}")
  kubectl exec $POD_NAME conjurctl account create quickstart
  `{{execute}}

Detailed instructions here: https://www.conjur.org/get-started/install-conjur.html#install-and-configure

>  Note that the conjurctl account create command gives you the public key and admin API key for the account you created.
>  Back them up in a safe location.

## 2. Connect to Conjur
  `docker run --rm -it --entrypoint bash cyberark/conjur-cli:5`{{execute}}

## 3. Verify the installation
  `conjur init -u [[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com -a quickstart`{{execute}}

  `conjur authn login -u admin`{{execute}}
  
  `conjur authn whoami`{{execute}}
  
  To exit Conjur CLI client:
  `exit`{{execute}}

## 4. Installation Completed!

Congratulations!  Conjur has been successfully deployed to Kubernetes!

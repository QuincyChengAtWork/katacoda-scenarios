
## 1. Get the application URL by running these commands:
  `export POD_NAME=$(kubectl get pods --namespace default -l "app=conjur-oss,release=famous-warthog" -ojsonpath="{.items[0].metadata.name}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl port-forward $POD_NAME 8080:80`{{execute}}

## 2. Configure Conjur
  To create an initial account as "quickstart" and login
  
  `export POD_NAME=$(kubectl get pods --namespace default -l "app=conjur-oss,release=famous-warthog" -ojsonpath="{.items[0].metadata.name}")
  kubectl exec $POD_NAME conjurctl account create quickstart`{{execute}}

Detailed instructions here: https://www.conjur.org/get-started/install-conjur.html#install-and-configure

>  Note that the conjurctl account create command gives you the
>  public key and admin API key for the account you created.
>  Back them up in a safe location.

## 3. Connect to Conjur
  `docker run --rm -it --entrypoint bash cyberark/conjur-cli:5`{{execute}}

  conjur init -u <ENDPOINT> -a <ACCOUNT>
  conjur authn login -u admin -p <API_KEY>
  conjur authn whoami
